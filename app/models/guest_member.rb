class GuestMember < ApplicationRecord
  belongs_to :event, class_name: 'GuestEvent'

  def as_json(options)
    super({ only: [:id, :name] })
  end
end
