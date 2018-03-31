class GroupsController < ApplicationController
  def show
    group = Group.find(params[:id])
    render json: group
  end

  def create
    group = Group.create!(name: params[:name], description: params[:description], members: [current_user])
    render json: group, status: 201
  end
end
