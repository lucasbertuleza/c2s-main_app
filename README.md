# WebTasks
<sup>Repositório parte do teste técnico da C2S.</sup>

Esta aplicação web é oponto de entrada (sistema principal) para usuários gerenciarem suas tarefas de web scraping. No diagrama a seguir ela é representada na cor azul.

![c4_container](https://github.com/user-attachments/assets/de1c731c-49d9-4a8a-b7d8-83533e09d18f)

O diagrama C4 apresenta uma visão geral da arquitetura da aplicação que é composta por mais 3 serviços:

- serviço de autenticação/autorização (cinza)
- serviço de notificação (vermelho)
- serviço de web scraping (verde)

A comunicação entre a webapp e o serviço de web scraping é feito através de um Message Broker (RabbitMQ). Cada tópico (representado na cor laranja) está associado a uma fila que corresponde a um status da tarefa.

## Fluxo de execução

1. O usuário cria/atualiza uma tarefa por meio da webapp e então uma requisição HTTP é enviada ao serviço de notificação
2. Caso o serviço de notificação confirme o recebimento (resposta com status `ok`), a webapp publica uma mensagem na fila de tarefas pendentes contendo os dados da tarefa
3. O serviço de scraping vai consumir as mensagens da fila e publicará uma mensagem indicando o início do processamento de determinada tarefa
4. Ao concluir, enviará uma requisição HTTP ao serviço de notificação com o resultado do processamento e, caso o serviço confirme o recebimento (respota com status `ok`), publicará uma mensagem na fila que corresponde ao status final da tarefa (sucesso ou falha), caso contrário, um `nack` é enviado ao broker recolocando a tarefa na fila pendentes
5. A webapp consome as mensagens enviadas pelo serviço scraping e atualiza o status das tarefas em tempo real, sem a necessidade de recarregar a página

Dica: Permita que a aplicação envie alertas ao browser (uma notificação será exibida sempre que uma tarefa for finalizada).

## Dependências

- Docker
- Docker Compose
- Portas 3000 e 8080 disponíveis para uso
- Serviço de notificação executando ([c2s-notification_service](https://github.com/lucasbertuleza/c2s-notification_service))
- Serviço de autenticação executando ([c2s-authentication_service](https://github.com/lucasbertuleza/c2s-authentication_service))
- Serviço de web scraping executando ([c2s-webscraping_service](https://github.com/lucasbertuleza/c2s-webscraping_service))

**Observação 1:** Talvez você encontre alguma dificuldade para fazer o build da aplicação caso esteja executando o Linux no Windows com o WSL. \
**Observação 2:** Se você utiliza o compose como plugin, utilize `docker-compose` ao invés de `docker compose` ao executar os comandos.

## Build

Caso você tenha o utilitário `make` instalado, basta executar o seguinte comando na raiz do projeto:

```sh
make build
```

Caso contrário:

```sh
cp .env.example .env
docker compose build
```

## Executando a aplicação

⚠️ **Atenção!** \
Esta aplicação têm como dependência outros 3 serviços que devem estar em execução para que a aplicação execute corretamente. Veja a seção [Dependências](#dependências).

```bash
make up
# ou
docker compose up -d
```

Verifique o status (**Up**) de todos os containers para garantir que não houve qualquer problema:

```bash
docker compose ps -a --format "table {{.Name}}\t{{.Status}}"
```

Acesse a URL https://localhost:3000 e confirme ao navegador que confia no certificado autoassinado para continuar. Isso é necessário porque a aplicação está com o TLS ativado e disponível apenas sob HTTPS.
