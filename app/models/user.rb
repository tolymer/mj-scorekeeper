class User < ApplicationRecord
  has_many :group_members
  has_many :event_members
  has_many :groups, through: :group_members
  has_many :events, through: :event_members
  has_many :game_scores
  has_many :auth_providers

  def self.find_or_create_by_auth_hash(auth_hash)
    uid, provider_name = auth_hash.values_at(:uid, :provider)
    auth_provider = AuthProvider.find_by(name: provider_name, uid: uid)
    return auth_provider.user if auth_provider

    name = auth_hash[:info][:nickname] || auth_hash[:info][:name]
    transaction do
      user = User.create!(name: name)
      user.auth_providers.create!(name: provider_name, uid: uid)
      user
    end
  end

  def as_json(options)
    super({ only: [:id, :name] })
  end
end
