FactoryBot.define do
  factory :event do
    sequence(:title) {|n| "event_#{n}" }
    description 'event description'
    date '2018-01-01'
    association :group
  end
end
