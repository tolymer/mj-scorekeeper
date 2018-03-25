class User < ApplicationRecord
  has_many :group_members
  has_many :event_members
  has_many :groups, through: :group_members
  has_many :events, through: :event_members
  has_many :game_scores
end
