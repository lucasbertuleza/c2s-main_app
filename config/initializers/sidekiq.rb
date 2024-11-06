require 'sidekiq/web'

# Rails HTTP Basic Auth
# See https://github.com/mperham/sidekiq/wiki/Monitoring for more options
# https://github.com/sidekiq/sidekiq/wiki/Using-Redis
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(
    ::Digest::SHA256.hexdigest(username),
    ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])
  ) & ActiveSupport::SecurityUtils.secure_compare(
    ::Digest::SHA256.hexdigest(password),
    ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"])
  )
end if Rails.env.production?

# Active Job queue adapter
Rails.application.config.active_job.queue_adapter = :sidekiq
