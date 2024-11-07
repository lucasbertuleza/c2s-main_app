class FailedTaskConsumer
  include Hutch::Consumer
  consume "scraper.task.failed"
  queue_name "failed_tasks"

  # @param message [Hutch::Message]
  # Exemplo de payload {task_id:, data:}
  def process(message)
    task = Task.find_by(uuid: message[:task_id])
    task.data[:error] = message[:error]
    task.failed!
  end
end
