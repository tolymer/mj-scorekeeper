class GuestEventsController < GuestBaseController
  def show
    event = find_event
    render json: event
  end

  def create
    event = GuestEvent.create!(event_params)
    render json: event, status: 201
  end

  def update
    event = find_event
    event.update!(event_params)
    render json: { result: 'ok' }
  end

  private

  def event_params
    params.permit(:title, :description, :date)
  end
end
