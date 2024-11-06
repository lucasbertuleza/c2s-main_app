module Support
  module MailHelper
    # Reads the fixture file for the given mailer.
    #
    # The name of the directory within `spec/fixtures` directly corresponds to
    # the name of the mailer. So, for a mailer named `UserMailer`, the fixtures
    # should reside in `spec/fixtures/user_mailer` directory.
    #
    # If you generated your mailer, the generator will create stub fixtures for
    # the mailer actions, but will not add the `_mailer` suffix to the directory.
    # You'll have to rename these directories yourself as described above.
    #
    # @param action [String]
    # @return [Array<String>] content from this file
    def read_fixture(action)
      Rails.root.join(
        "spec/fixtures", self.class.mailer_class.name.underscore, action
      ).readlines(chomp: true).select(&:present?)
    end
  end
end

RSpec.configure do |config|
  config.include Support::MailHelper, type: :mailer
end
