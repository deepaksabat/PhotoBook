tom = User.where(email: 'tom@gmail.com').pluck(:id).first
jack = User.where(email: 'jack@gmail.com').pluck(:id).first
matt = User.where(email: 'matt@gmail.com').pluck(:id).first

Post.create!([
    {
        caption: 'Apple watch',
        user_id: tom,
        image: File.new("#{Rails.root}/db/seeds/images/apple-watch.jpg")
    },
    {
        caption: 'iPhone 5C',
        user_id: tom,
        image: File.new("#{Rails.root}/db/seeds/images/iPhone-5C.jpg")
    },
    {
        caption: 'iPhone 6',
        user_id: jack,
        image: File.new("#{Rails.root}/db/seeds/images/iPhone-6.jpg")
    }
])

puts("#{Post.count} posts(s) have been created")