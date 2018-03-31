class CurrentUsersController < ApplicationController
  def show
    render json: current_user
  end

  def groups
    render json: current_user.groups
  end
end
