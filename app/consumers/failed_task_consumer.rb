class FailedTaskConsumer
  include Hutch::Consumer
  consume "scraper.task.failed"
  queue_name "failed_tasks"

  # @param message [Hutch::Message]
  #   Exemplo de payload {task_id:, data:, user:}
  def process(message)
    task = Task.find_by(uuid: message[:task_id])
    task.data[:erro] = message[:error]
    task.failed!

    WebNotificationsChannel.broadcast_to(
      message[:user],
      uuid: task.uuid,
      status: "Falha",
      data: task.data
    )
  end
end
