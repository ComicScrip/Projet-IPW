FactoryGirl.define do
  factory :user do
    firstName "John"
    lastName "Doe"
    password "password"
    password_confirmation "password"
    approved true
    sequence(:email) { |n| "#{firstName}.#{lastName}-#{n}@example.com".downcase }

    factory :admin do
      firstName "Admin"
      lastName "Adminison"

      after(:create) do |u, evalulator|
        u.add_role "admin"
      end
    end

    factory :teacher do
      firstName "Teacher"
      lastName "Teacherson"

      after(:create) do |u, evalulator|
        u.add_role "teacher"
      end
    end
  end
end