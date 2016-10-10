FactoryGirl.define do
  factory :comment do
    user
    post
    content Faker::Lorem.paragraph(2)
  end
end
