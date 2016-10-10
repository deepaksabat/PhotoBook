require 'rails_helper'

describe Comment do
  it { should belong_to(:user) }
  it { should belong_to(:post) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:post_id) }
  it { should validate_presence_of(:content) }
  it { should validate_length_of(:content).is_at_least(2).is_at_most(300) }
end
