class GuestMembersController < GuestBaseController
  def index
    event = find_event
    render json: event.members
  end

  def create
    event = find_event
    event.members = params[:names].map { |name| GuestMember.new(name: name) }
    event.save!
    render json: { result: 'ok' }, status: 201
  end
end
