require 'spec_helper'

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }
end
