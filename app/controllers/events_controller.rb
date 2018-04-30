class EventsController < ApplicationController
  def index
    group = Group.find(params[:group_id])
    render json: group.events.order(created_at: :desc)
  end

  def show
    event = Event.find(params[:id])
    render json: event
  end

  def create
    group = Group.find(params[:group_id])
    event = group.events.create!(event_params)
    render json: event, status: 201
  end

  def update
    event = Event.find(params[:id])
    event.update!(event_params)
    render json: { result: 'ok' }
  end

  def destroy
    Event.find(params[:id]).destroy
    render json: { result: 'ok' }
  end

  private

  def event_params
    params.permit(:title, :description, :date)
  end
end
