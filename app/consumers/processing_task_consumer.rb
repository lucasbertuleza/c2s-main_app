class ProcessingTaskConsumer
  include Hutch::Consumer
  consume "scraper.task.progress"
  queue_name "processing_tasks"

  # @param message [Hutch::Message]
  # Exemplo de payload {task_id:, status:}
  def process(message)
    task = Task.find_by(uuid: message[:task_id])
    task.processing!
  end
end
