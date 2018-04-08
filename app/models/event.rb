class Event < ApplicationRecord
  has_many :event_members
  has_many :members, through: :event_members, source: :user
  has_many :games
  has_many :tips

  belongs_to :group

  def as_json(options)
    super(only: [:id, :title, :description, :date, :group_id, :created_at])
  end
end
