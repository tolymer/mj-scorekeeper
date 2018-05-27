class GuestGamesController < GuestBaseController
  def index
    event = find_event
    render json: event.games.order(created_at: :asc)
  end

  def create
    event = find_event
    game = event.games.create!
    game.update!(scores: scores)
    render json: game, status: 201
  end

  def update
    game = GuestGame.find(params[:id])
    game.scores = scores
    render json: { 'result': 'ok' }, status: 200
  end

  def destroy
    GuestGame.find(params[:id]).destroy
    render json: { result: 'ok' }
  end

  private

  def scores
    params['scores'].map do |score|
      GuestGameScore.new(member_id: score['member_id'], point: score['point'].to_i)
    end
  end
end
