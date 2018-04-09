class GroupsController < ApplicationController
  def show
    group = Group.find(params[:id])
    render json: group
  end

  def create
    group = Group.create!(group_params.merge(members: [current_user]))
    render json: group, status: 201
  end

  def update
    group = Group.find(params[:id])
    group.update!(group_params)
    render json: { result: 'ok' }
  end

  def stats
    group = Group.find(params[:id])
    render json: group.stats
  end

  private

  def group_params
    params.permit(:name, :description)
  end
end
