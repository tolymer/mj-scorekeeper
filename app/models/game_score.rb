class GameScore < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :rank,
    inclusion: {
      in: [1, 2, 3, 4],
      message: "Invalid rank: %{value}"
    }

  validates :point,
    numericality: {
      only_integer: true,
      message: "Invalid point: %{value}"
    }

end
