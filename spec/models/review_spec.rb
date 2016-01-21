require 'spec_helper'

describe Review, type: :model do
  it { is_expected.to belong_to :restaurant }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }

  describe '#created_by?' do
    let!(:this_user) do
      User.create(email: 'test@example.com',
                  password: 'testtest',
                  password_confirmation: 'testtest')
    end

    it 'should return true if created by that user' do
      review = Review.create(rating: 5, user: this_user)
      expect(review.created_by?(this_user)).to be true
    end

    it 'should return false if not created by that user' do
      review = Review.create(rating: 3)
      expect(review.created_by?(this_user)).to be false
    end
  end
end
