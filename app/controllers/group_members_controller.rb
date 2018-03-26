class GroupMembersController < ApplicationController
  def index
    group = Group.find(params[:group_id])
    render json: group.members
  end

  def create
    group = Group.find(params[:group_id])
    user = User.find(params[:user_id])
    group.members << user
    render json: user, status: 201
  end
end
