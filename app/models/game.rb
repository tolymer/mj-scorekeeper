class Game < ApplicationRecord
  has_many :scores, class_name: 'GameScore'

  belongs_to :event
end
