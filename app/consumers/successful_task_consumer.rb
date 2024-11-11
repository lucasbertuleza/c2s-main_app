class SuccessfulTaskConsumer
  include Hutch::Consumer
  consume "scraper.task.success"
  queue_name "successful_tasks"

  # @param message [Hutch::Message]
  #   Exemplo de payload {task_id:, data:, user:}
  def process(message)
    task = Task.find_by(uuid: message[:task_id])
    task.data = message[:data].except(:url)
    task.successful!

    WebNotificationsChannel.broadcast_to(
      message[:user],
      uuid: task.uuid,
      status: "Concluída",
      data: task.data
    )
  end
end
