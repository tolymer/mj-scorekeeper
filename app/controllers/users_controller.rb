class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:show, :create]

  def show
    render json: User.find(params[:id])
  end
end
