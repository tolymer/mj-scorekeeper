class Tip < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def as_json(options)
    super(only: [:user_id, :point])
  end
end
