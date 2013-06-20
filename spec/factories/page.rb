FactoryGirl.define do
  factory :page do
    title { Faker::Lorem.words.first }
    content { Faker::Lorem.paragraph(2) }
    association :user
  end

  factory :unpublished_page, parent: :page do
    published_on nil
  end

  factory :published_page, parent: :page do
    published_on Date.yesterday
  end
end
