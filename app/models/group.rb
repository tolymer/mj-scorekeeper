class Group < ApplicationRecord
  has_many :group_members
  has_many :members, through: :group_members, source: :user
  has_many :events
end
