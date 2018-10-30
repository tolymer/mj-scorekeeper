class Grpc::GuestService < Tolymer::Guest::Service
  def get_event(req, _call)
    event = GuestEvent.find_by!(token: req.event_token)
    Tolymer::GetEventResponse.new(event: event.to_proto)
  end

  def create_event(req, _call)
    event = GuestEvent.create!(
      title: req.title,
      description: req.description,
      date: req.date,
    )
    event.members = req.members.map { |name| GuestMember.new(name: name) }
    Tolymer::CreateEventResponse.new(event_token: event.token)
  end

  def update_event(req, _call)
    event = GuestEvent.find_by!(token: req.event_token)
    event.update!(
      title: req.title,
      description: req.description,
      date: req.date,
    )
    event.members = req.members.map { |name| GuestMember.new(name: name) }
    Tolymer::UpdateEventResponse.new(result: true)
  end

  def create_game(req, _call)
    event = GuestEvent.find_by!(token: req.event_token)
    game = event.games.create!
    req.scores.each do |score|
      game.scores.create!(score.to_hash)
    end
    Tolymer::CreateGameResponse.new(game_id: game.id)
  end

  def update_game(req, _call)
    game = GuestGame.find(req.game_id)
    game.scores.destroy_all
    req.scores.each do |score|
      game.scores.create!(score.to_hash)
    end
    Tolymer::UpdateGameResponse.new(result: true)
  end
end
