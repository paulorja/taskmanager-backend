class StatusController < ApplicationController

  # GET /status
  def index
    @status = Status.all
    
    render json: @status
  end

end
