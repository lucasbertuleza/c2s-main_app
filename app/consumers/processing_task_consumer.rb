class ProcessingTaskConsumer
  include Hutch::Consumer
  consume "scraper.task.progress"
  queue_name "processing_tasks"

  # @param message [Hutch::Message]
  #   Exemplo de payload {task_id:, user:}
  def process(message)
    task = Task.find_by(uuid: message[:task_id])
    task.processing!

    WebNotificationsChannel.broadcast_to(
      message[:user],
      uuid: task.uuid,
      status: "Em progresso"
    )
  end
end
