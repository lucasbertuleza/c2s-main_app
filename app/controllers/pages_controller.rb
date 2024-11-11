class PagesController < ApplicationController
  before_action { redirect_to tasks_path if logged_in? }

  def sign_in
  end

  def sign_up
  end
end
