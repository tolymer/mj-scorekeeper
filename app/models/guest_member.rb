class GuestMember < ApplicationRecord
  belongs_to :event, class_name: 'GuestEvent'

  def as_json(options)
    super({ only: [:id, :name] })
  end

  def to_proto
    Tolymer::Member.new(id: id, name: name)
  end
end
