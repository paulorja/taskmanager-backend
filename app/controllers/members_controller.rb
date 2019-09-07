class MembersController < ApplicationController

  # GET /members
  def index
    @members = Member.all
    
    render json: @members
  end

end
