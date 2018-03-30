class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:show, :create]

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.create!(name: params[:name], password: params[:password])
    render json: user, status: 201
  end
end
