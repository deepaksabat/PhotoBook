tom = User.where(email: 'tom@gmail.com').pluck(:id).first
jack = User.where(email: 'jack@gmail.com').pluck(:id).first
matt = User.where(email: 'matt@gmail.com').pluck(:id).first

Comment.create!([
    {
        user_id: tom,
        post_id: Post.first.id,
        content: Faker::Lorem.paragraph(2)
    },
    {
        user_id: tom,
        post_id: Post.first.id,
        content: Faker::Lorem.paragraph(2)
    },
    {
        user_id: jack,
        post_id: Post.last.id,
        content: Faker::Lorem.paragraph(2)
    },
    {
        user_id: matt,
        post_id: Post.last.id,
        content: Faker::Lorem.paragraph(2)
    },

])
puts("#{Comment.count} comment(s) have been created")