class Event < ApplicationRecord
  has_many :event_members
  has_many :members, through: :event_members, source: :user
  has_many :games

  belongs_to :group
end
