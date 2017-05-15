FactoryGirl.define do
  factory :assessment do
    grade 15
    association :student, factory: :user
    exam
  end
end
