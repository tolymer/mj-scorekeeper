FactoryBot.define do
  factory :event_member do
    association :user
    association :event
  end
end
