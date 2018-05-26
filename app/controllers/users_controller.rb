class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:show, :update]

  def show
    render json: User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update!(user_params)
    render json: { result: 'ok' }
  end

  def user_params
    params.permit(:name)
  end
end
