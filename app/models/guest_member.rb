class GuestMember < ApplicationRecord
  belongs_to :event, class_name: 'GuestEvent', foreign_key: 'guest_event_id'

  def as_json(options)
    super({ only: [:id, :name] })
  end
end
