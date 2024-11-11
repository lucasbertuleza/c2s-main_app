class ApplicationController < ActionController::Base
  include Session

  helper_method :current_user, :logged_in?
end
