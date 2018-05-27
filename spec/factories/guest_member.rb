FactoryBot.define do
  factory :guest_member do
    sequence(:name) {|n| "name_#{n}" }
    association :event, factory: :guest_event
  end
end
