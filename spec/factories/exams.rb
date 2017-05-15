FactoryGirl.define do
  factory :exam do
    title "CC1"
    date "2017-05-05"
    association :discipline, factory: :discipline
  end
end
