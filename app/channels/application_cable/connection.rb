module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if (verified_user = cookies.encrypted["_main_app_session"].dig("user", "email"))
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
