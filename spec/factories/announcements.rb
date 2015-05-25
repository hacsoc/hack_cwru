FactoryGirl.define do
  factory :announcement do
    title { Forgery::LoremIpsum.sentence }
    content { Forgery::LoremIpsum.paragraph }
    association :author, factory: :user
  end
end
