class PrioritiesController < ApplicationController

  # GET /priorities
  def index
    @priorities = Priority.all
    
    render json: @priorities
  end

end
