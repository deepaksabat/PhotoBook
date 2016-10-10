require 'rails_helper'

describe Post do
  it { should belong_to(:user) }
  it { should have_many(:comments).dependent(:destroy) }

  it { should validate_presence_of(:user_id) }
  it { should validate_length_of(:caption).is_at_least(2).is_at_most(300) }

  it { should have_attached_file(:image) }
  it { should validate_attachment_presence(:image) }
  it { should validate_attachment_content_type(:image)
    .allowing('image/png', 'image/gif', 'image/jpg')
    .rejecting('text/plain', 'text/xml')
  }
  it { should validate_attachment_size(:image).less_than(2.megabytes) }
end
