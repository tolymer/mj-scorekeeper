class Game < ApplicationRecord
  has_many :scores, class_name: 'GameScore'

  belongs_to :event

  def as_json(options)
    super({
      only: [:id, :event_id],
      include: { scores: { only: [:user_id, :point] } }
    })
  end
end
