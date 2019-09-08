class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy, :move, :transfer]

  # GET /tasks
  def index
    @tasks = Task.order(position: :asc).all

    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  # MOVE /tasks/1/move
  def move
    if @task.move(params[:position])
      render json: @task
    else
      render json: false, status: :unprocessable_entity
    end
  end

  # TRANSFER /tasks/1/transfer
  def transfer 
    if @task.transfer(params[:position], params[:status_id])
      render json: @task
    else
      render json: false, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :description, :date, :priority_id, :member_id, :status_id)
    end
end
