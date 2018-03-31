FactoryBot.define do
  factory :group do
    sequence(:name) {|n| "group_#{n}" }
    description 'group description'
  end
end
