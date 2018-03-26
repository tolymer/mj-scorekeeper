class EventMembersController < ApplicationController
  def index
    event = Event.find(params[:event_id])
    render json: event.members
  end

  def create
    event = Event.find(params[:event_id])
    user = User.find(params[:user_id])
    event.members << user
    render json: user, status: 201
  end
end
