FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    password 'password' 
    role User::CONTENT_PROVIDER
  end

  factory :admin, parent: :user do
    role User::ADMIN
  end
end
