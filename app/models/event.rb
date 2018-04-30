class Event < ApplicationRecord
  has_many :event_members, dependent: :delete_all
  has_many :members, through: :event_members, source: :user
  has_many :games, dependent: :delete_all
  has_many :ordered_games, -> { order(created_at: :desc) }, class_name: 'Game'
  has_many :tips

  belongs_to :group

  def as_json(options)
    super(only: [:id, :title, :description, :date, :group_id, :created_at])
  end
end
