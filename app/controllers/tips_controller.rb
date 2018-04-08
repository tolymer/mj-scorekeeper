class TipsController < ApplicationController
  def index
    event = Event.find(params[:event_id])
    render json: event.tips.all
  end

  def create
    event = Event.find(params[:event_id])
    event.transaction do
      event.tips.destroy_all
      params[:tips].each { |tip| event.tips.create!(user_id: tip[:user_id], point: tip[:point]) }
    end
    render json: { result: 'ok' }, status: 200
  end
end
