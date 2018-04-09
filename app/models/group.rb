class Group < ApplicationRecord
  has_many :group_members
  has_many :members, through: :group_members, source: :user
  has_many :events
  has_many :tips

  def stats
    events.preload([:tips, { ordered_games: :scores }]).map do |event|
      scores = event.ordered_games.map do |g|
        g.scores.map do |s|
          s.slice(:user_id, :point, :rank)
        end
      end

      {
        date: event.date,
        scores: scores,
        tips: event.tips
      }
    end
  end

  def as_json(options)
    super(only: [:id, :name, :description])
  end
end
