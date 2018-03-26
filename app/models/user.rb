class User < ApplicationRecord
  has_secure_password

  has_many :group_members
  has_many :event_members
  has_many :groups, through: :group_members
  has_many :events, through: :event_members
  has_many :game_scores

  def self.from_token_request(request)
    name = request.params.dig('auth', 'name')
    find_by(name: name)
  end

  def as_json(options)
    super({ only: [:id, :name] })
  end
end
