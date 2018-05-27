class GuestGameScore < ApplicationRecord
  belongs_to :game, class_name: 'GuestGame'
  belongs_to :member, class_name: 'GuestMember'
end
