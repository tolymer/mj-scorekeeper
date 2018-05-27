class GuestEvent < ApplicationRecord
  has_many :members, dependent: :destroy, class_name: 'GuestMember'
  has_many :games, dependent: :destroy, class_name: 'GuestGame'
  has_many :ordered_games, -> { order(created_at: :desc) }, class_name: 'GuestGame'
  has_many :tips, dependent: :destroy, class_name: 'GuestTip'

  def as_json(options)
    super(only: [:token, :title, :description, :date, :created_at])
  end
end
