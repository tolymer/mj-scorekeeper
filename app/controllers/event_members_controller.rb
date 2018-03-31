class EventMembersController < ApplicationController
  def index
    event = Event.find(params[:event_id])
    render json: event.members
  end

  def create
    event = Event.find(params[:event_id])
    users = User.where(id: params[:user_ids])
    event.members << users
    render json: users, status: 201
  end
end
