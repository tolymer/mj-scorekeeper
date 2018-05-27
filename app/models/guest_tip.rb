class GuestTip < ApplicationRecord
  def as_json(options)
    super(only: [:guest_member_id, :point])
  end
end
