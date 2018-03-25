class UsersController < ApplicationController
  def show
    render json: current_user.to_json(only: :name)
  end
end
