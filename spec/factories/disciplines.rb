FactoryGirl.define do
  factory :discipline do
    name "IPW"
    beginsOn "2017-03-05"
    endsOn "2017-05-20"
    association :owner, factory: :teacher
  end
end
