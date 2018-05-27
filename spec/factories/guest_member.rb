FactoryBot.define do
  factory :guest_member do
    sequence(:name) {|n| "user_#{n}" }
    association :event
  end
end
