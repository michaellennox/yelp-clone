require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_length_of(:name).is_at_least(3) }
  it { is_expected.to validate_uniqueness_of(:name) }

  describe '#created_by?' do
    let!(:this_user) do
      User.create(email: 'test@example.com',
                  password: 'testtest',
                  password_confirmation: 'testtest')
    end

    it 'should return true if created by that user' do
      restaurant = Restaurant.create(name: 'katsu king', user: this_user)
      expect(restaurant.created_by?(this_user)).to be true
    end

    it 'should return false if not created by that user' do
      restaurant = Restaurant.create(name: 'katsu king')
      expect(restaurant.created_by?(this_user)).to be false
    end
  end
end
