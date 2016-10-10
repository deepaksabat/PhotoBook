require 'rails_helper'

describe User do
  it { should have_many(:posts).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(2).is_at_most(30) }
end
