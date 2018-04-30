class GamesController < ApplicationController
  def index
    event = Event.find(params[:event_id])
    render json: event.games.order(created_at: :asc)
  end

  def create
    event = Event.find(params[:event_id])
    game = event.games.create!(scores: scores)
    render json: game, status: 201
  end

  def update
    game = Game.find(params[:id])
    game.transaction do
      game.scores.destroy_all
      game.scores << scores
    end
    render json: { 'result': 'ok' }, status: 200
  end

  def destroy
    Game.find(params[:id]).destroy
    render json: { result: 'ok' }
  end

  private

  def scores
    params['scores'].sort_by { |s| s['point'].to_i }.reverse.map.with_index(1) do |score, rank|
      GameScore.new(user_id: score['user_id'], point: score['point'].to_i, rank: rank)
    end
  end
end
