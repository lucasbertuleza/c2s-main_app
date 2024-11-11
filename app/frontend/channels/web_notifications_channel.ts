/* eslint-disable no-alert */
/* eslint-disable no-new */
import consumer from './consumer';

interface Vehicle {
  marca?: string;
  modelo?: string;
  preco?: string;
  info?: string;
  erro?: string;
}

interface Task {
  uuid: string;
  status: string;
  data: Vehicle;
}

consumer.subscriptions.create('WebNotificationsChannel', {
  async received(task: Task) {
    const dados = this.updateTask(task);
    await this.notify(task, dados);
  },

  async notify(task: Task, data: string) {
    const title = `Status de tarefa atualizado!`;
    const body = { body: `Status: ${task.status}\nDados:\n${data}` };

    if (!('Notification' in window)) {
      alert('Este navegador não suporta notificações Desktop');
    } else if (Notification.permission === 'granted') {
      new Notification(title, body);
    } else if (Notification.permission !== 'denied') {
      await Notification.requestPermission().then((permission) => {
        if (permission === 'granted') {
          new Notification(title, body);
        }
      });
    }
  },

  updateTask(task: Task): string {
    const $task = document.querySelector(`div[data-uuid="${task.uuid}"]`);
    if (!$task) return 'Nenhum dado à ser exibido';

    const $status = $task.querySelector('span.status');
    const $data = $task.querySelector('span.dados');
    if ($status) $status.textContent = task.status;

    const erro = task.data.erro && `Erro: ${task.data.erro}`;
    const marca = task.data.marca && `Marca: ${task.data.marca}`;
    const modelo = task.data.modelo && `Modelo: ${task.data.modelo}`;
    const preco = task.data.preco && `Preço: ${task.data.preco}`;
    const info = task.data.info && `Info: ${task.data.info}`;
    const dados = [erro, marca, modelo, preco, info].filter((elm) => !!elm).join(' | ');
    if ($data) $data.textContent = dados;

    return dados;
  },
});
