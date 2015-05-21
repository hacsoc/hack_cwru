FactoryGirl.define do
  factory :user do
    name 'A name'
    sequence(:email) { |n| "person#{n}@example.com" }
    institution 'An institution'
    password 'C0mplicatedPassword'
  end
end
