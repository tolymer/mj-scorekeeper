class User < ApplicationRecord
  has_many :group_members
  has_many :event_members
  has_many :groups, through: :group_members
  has_many :events, through: :event_members
  has_many :game_scores
  has_many :authentications

  def self.find_or_create_by_auth_hash(auth_hash)
    uid, provider = auth_hash.values_at(:uid, :provider)
    auth = Authentication.find_by(uid: uid, provider: provider)
    return auth.user if auth

    name = auth_hash[:info][:nickname] || auth_hash[:info][:name]
    transaction do
      user = User.create!(name: name)
      user.authentications.create!(uid: uid, provider: provider)
      user
    end
  end

  def as_json(options)
    super({ only: [:id, :name] })
  end
end
