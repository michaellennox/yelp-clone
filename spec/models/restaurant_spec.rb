require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }
  it { is_expected.to validate_length_of(:name).is_at_least(3) }
end
