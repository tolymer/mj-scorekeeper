FactoryBot.define do
  factory :event do
    sequence(:title) {|n| "event_#{n}" }
    date '2018-01-01'
    association :group
  end
end
