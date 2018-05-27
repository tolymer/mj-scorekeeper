FactoryBot.define do
  factory :guest_game do
    association :event, factory: :guest_event
  end
end
