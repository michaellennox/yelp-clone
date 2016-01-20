require 'spec_helper'

describe User, type: :model do
  it { is_expected.to have_many :restaurants }
  it { is_expected.to have_many :reviews }
  it { is_expected.to have_many :reviewed_restaurants }

  describe '#has_reviewed?' do
    let!(:restaurant) { Restaurant.create(name: 'blue dragon') }
    let!(:user) do
      User.create(email: 'test@example.com',
                  password: 'testtest',
                  password_confirmation: 'testtest')
    end

    it 'returns true if user has reviewed a restaurant' do
      Review.create(user: user, restaurant: restaurant, rating: 2)
      expect(user.has_reviewed?(restaurant)).to be true
    end

    it 'returns false if a user hasn\'t reviewed a restaurant' do
      expect(user.has_reviewed?(restaurant)).to be false
    end
  end
end
