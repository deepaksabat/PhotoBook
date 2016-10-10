FactoryGirl.define do
  factory :post do
    user
    caption Faker::Name.title
    image   Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/images/image.png", 'image/png')
  end
end
