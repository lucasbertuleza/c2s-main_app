unless Rails.env.production?
  DEFAULT_URL_OPTIONS_LOCAL_ENV = {
    host: Rails.env.development? ? "localhost" : IPSocket.getaddress(Socket.gethostname),
    port: Rails.env.development? ? 3000 : nil,
    protocol: Rails.env.development? ? "https" : "http"
  }.freeze

  # Allow generating absolute urls with routing url helpers.
  Rails.application.routes.default_url_options = DEFAULT_URL_OPTIONS_LOCAL_ENV

  Rails.application.configure do
    # Allow MailCatcher to catch any messages sent to it for display in a web interface.
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = { address: "mailserver", port: 1025 }
    config.action_mailer.default_url_options = DEFAULT_URL_OPTIONS_LOCAL_ENV
  end if Rails.env.development?
end
