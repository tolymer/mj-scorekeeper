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
    event = group.events.create!(title: params[:title], description: params[:description], date: params[:date])
    render json: event, status: 201
  end
end
