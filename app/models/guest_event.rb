class GuestEvent < ApplicationRecord
  has_many :members, dependent: :destroy, class_name: 'GuestMember', foreign_key: :event_id
  has_many :games, dependent: :destroy, class_name: 'GuestGame', foreign_key: :event_id
  has_many :tips, dependent: :destroy, class_name: 'GuestTip', foreign_key: :event_id

  before_create :set_token

  def set_token
    self.token ||= SecureRandom.hex
  end

  def as_json(options)
    super(only: [:token, :title, :description, :date, :created_at])
  end

  def to_proto
    Tolymer::Event.new(
      token: token,
      title: title,
      description: description,
      date: date.to_s,
      members: members.map(&:to_proto),
      games: games.map(&:to_proto),
    )
  end
end
