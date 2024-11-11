class TasksController < ApplicationController
  NOTIFICATION_ENDPOINT = URI("http://notification_service_app:3000/v1").freeze
  NOTIFICATION_HEADERS = {"content-type" => "application/json"}.freeze

  before_action :authenticate_user
  before_action :set_task, -> { check_owner(@task) }, only: %i[show edit update destroy]

  # GET /tasks
  def index
    @tasks = Task.where(user_id: current_user.id)
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(user_id: current_user.id, **task_params)
    return (render :new, status: :unprocessable_entity) unless @task.save
    send_notification("create", "Nova tarefa criada")
    render :show
  end

  # PATCH/PUT /tasks/1
  def update
    @task.data = {}
    return (render :edit, status: :unprocessable_entity) unless @task.update(task_params)
    send_notification("update", "Tarefa atualizada")
    redirect_to @task, status: :see_other
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy!
    redirect_to tasks_url, notice: "Tarefa excluída com sucesso", status: :see_other
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:url)
  end

  # @param action [String] create | update
  # @param info [String] desrição
  def send_notification(action, info)
    payload = payload_for_notification(action, info)
    response = Net::HTTP.post(NOTIFICATION_ENDPOINT, payload, NOTIFICATION_HEADERS)
    return (flash[:alert] = "Não foi possível salvar a tarefa.") unless response.code == "200"
    Hutch.connect
    Hutch.publish("scraper.task.pending",
      task_id: @task.uuid,
      url: @task.url,
      user: current_user.email)
    flash.now[:notice] = "#{info} com sucesso."
  rescue Net::ReadTimeout
    flash.now[:alert] = "Notificação não confirmada."
    @task.failed!
  end

  # @return [String] JSON string
  def payload_for_notification(action, info)
    payload = @task.as_json
    payload[:task].merge!(action:, user: current_user.email)
    payload[:notification] = {info:, data: payload[:task].except(:uuid)}
    payload.to_json
  end
end
