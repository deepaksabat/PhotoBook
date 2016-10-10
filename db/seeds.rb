Comment.destroy_all
Post.destroy_all
User.destroy_all

require_relative('./seeds/users')
require_relative('./seeds/posts')
require_relative('./seeds/comments')
