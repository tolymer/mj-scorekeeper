class GuestGame < ApplicationRecord
  has_many :scores, class_name: 'GuestGameScore', dependent: :destroy

  belongs_to :event

  def as_json(options)
    super({
      only: [:id, :event_id],
      include: { scores: { only: [:guest_member_id, :point] } }
    })
  end
end
