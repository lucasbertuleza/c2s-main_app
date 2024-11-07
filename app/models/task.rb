class Task < ApplicationRecord
  enum :status, pending: 0, processing: 1, successful: 2, failed: 3

  after_initialize do |task|
    task.uuid ||= SecureRandom.uuid
    task.data ||= {}
  end

  with_options presence: true do
    validates :url
    validates :user_id
    validates :uuid
  end

  # @return [Hash{Symbol:Hash}]
  def as_json
    {task: {url:, uuid:}}
  end
end
