FactoryBot.define do
  factory :guest_event do
    sequence(:title) {|n| "event_#{n}" }
    description 'event description'
    date '2018-01-01'
  end
end
