if defined?(BetterHtml)
  BetterHtml.configure do |config|
    config.template_exclusion_filter = proc { |filename|
      !filename.start_with?(Rails.root.to_s)
    }
  end
end
