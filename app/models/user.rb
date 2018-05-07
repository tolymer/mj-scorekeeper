class User < ApplicationRecord
  has_secure_password

  has_many :group_members
  has_many :event_members
  has_many :groups, through: :group_members
  has_many :events, through: :event_members
  has_many :game_scores

  def self.from_omniauth(auth)
    user = find_by(uid: auth.uid)

    unless user
      User.create(
        name: auth.info.name,
        provider: auth.provider,
        uid: auth.uid,
        token: auth.credentials.token,
        confirmed_at: Time.zone.now
      )

    user
  end

  def as_json(options)
    super({ only: [:id, :name] })
  end
end
