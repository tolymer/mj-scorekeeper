class GroupMembersController < ApplicationController
  def index
    group = Group.find(params[:group_id])
    render json: group.members
  end

  def create
    group = Group.find(params[:group_id])
    group.members << current_user
    render json: { result: 'ok' }, status: 201
  end
end
