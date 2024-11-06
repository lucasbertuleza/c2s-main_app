Rails.application.configure do
  # ActiveRecord Encryption
  # https://guides.rubyonrails.org/active_record_encryption.html
  config.active_record.encryption.extend_queries = true
end
