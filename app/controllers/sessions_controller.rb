class SessionsController < ApplicationController
  SIGNUP_ENDPOINT = URI("http://authentication_service_app:3000/v1/users").freeze
  SIGNIN_ENDPOINT = URI("http://authentication_service_app:3000/v1/tokens").freeze

  def sign_up
    response = Net::HTTP.post SIGNUP_ENDPOINT,
      credential_params,
      {"content-type" => "application/json"}

    unless response.code == "201"
      flash.now.alert = JSON.parse(response.body)
      return render "pages/sign_up"
    end

    flash.now.notice = "Conta criada com sucesso! Faça login para continuar."
    render "pages/sign_in"
  end

  def sign_in
    response = Net::HTTP.post SIGNIN_ENDPOINT,
      credential_params,
      {"content-type" => "application/json"}

    unless response.code == "200"
      flash.now.alert = JSON.parse(response.body)
      return render "pages/sign_in"
    end

    user = JSON.parse(response.body)
    log_in(user)
    redirect_to tasks_path, notice: "Seja bem vindo!"
  end

  def destroy
    log_out
    redirect_to sign_in_path, notice: "Conta desconectada com sucesso!"
  end

  private

  def credential_params
    params.permit(user: [:email, :password]).slice(:user).to_json
  end
end
