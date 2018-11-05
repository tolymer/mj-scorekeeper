class GuestGameScore < ApplicationRecord
  belongs_to :game, class_name: 'GuestGame'
  belongs_to :member, class_name: 'GuestMember'

  def to_proto
    Tolymer::Score.new(member_id: member_id, point: point)
  end
end
