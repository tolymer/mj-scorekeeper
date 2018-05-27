class GuestTip < ApplicationRecord
  belongs_to :event, class_name: 'GuestEvent'
  belongs_to :member, class_name: 'GuestMember'

  def as_json(options)
    super(only: [:member_id, :point])
  end
end
