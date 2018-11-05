class GuestGame < ApplicationRecord
  belongs_to :event, class_name: 'GuestEvent'
  has_many :scores, class_name: 'GuestGameScore', foreign_key: :game_id, dependent: :destroy

  def as_json(options)
    super({
      only: [:id, :event_id],
      include: { scores: { only: [:member_id, :point] } }
    })
  end

  def to_proto
    Tolymer::Game.new(
      id: id,
      event_id: event_id,
      scores: scores.map(&:to_proto),
    )
  end
end
