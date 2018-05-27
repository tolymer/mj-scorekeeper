class GuestTipsController < GuestBaseController
  def index
    event = find_event
    render json: event.tips.all
  end

  def create
    event = find_event
    event.transaction do
      event.tips.destroy_all
      params[:tips].each { |tip| event.tips.create!(member_id: tip[:member_id], point: tip[:point]) }
    end
    render json: { result: 'ok' }, status: 200
  end
end
