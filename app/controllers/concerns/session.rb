# Módulo que contém métodos auxiliares para gerenciar a sessão do usuário a
# partir das views e controllers.
module Session
  private

  AUTHORIZATION_ENDPOINT = URI("http://authentication_service_app:3000/v1/authorization").freeze

  def current_user
    @_current_user ||= check_authorization
  end

  def logged_in?
    !!current_user
  end

  def current_user?(user_id)
    current_user.id == user_id
  end

  def log_in(user)
    reset_session
    session[:user] = user["user"]
    session[:token] = user["token"]
  end

  def log_out
    reset_session
  end

  def authenticate_user
    redirect_to sign_in_path, alert: "Faça Login antes de continuar." unless logged_in?
  end

  # @param resource [#user_id]
  def check_owner(resource)
    head :forbidden unless current_user? resource.user_id
  end

  # @return [User, nil]
  def check_authorization
    return nil unless session[:token]

    headers = {"content-type": "application/json", Authorization: session[:token]}
    res = Net::HTTP.post AUTHORIZATION_ENDPOINT, "", headers
    return nil unless res.code == "200"

    user_info = session[:user].merge(id: JSON.parse(res.body)["user_id"])
    Utils::Structurize(user_info)
  end
end

# @!parse
#   class User
#     # @return [Integer]
#     attr_reader :id
#     # @return [String]
#     attr_reader :email
#   end
