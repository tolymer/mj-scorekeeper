class GuestBaseController < ActionController::API
  def find_event
    GuestEvent.find_by(token: params[:guest_event_token] || params[:token])
  end
end
