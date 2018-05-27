class GuestEvent < ApplicationRecord
  has_many :members, dependent: :destroy, class_name: 'GuestMember'
  has_many :games, dependent: :destroy, class_name: 'GuestGame'
  has_many :tips, dependent: :destroy, class_name: 'GuestTip'

  before_create :set_token

  def set_token
    self.token ||= SecureRandom.hex
  end

  def as_json(options)
    super(only: [:token, :title, :description, :date, :created_at])
  end
end
