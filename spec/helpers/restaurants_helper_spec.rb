require 'rails_helper'

describe RestaurantsHelper, type: :helper do
  describe '#star_rating' do
    it 'when passed "N/A", returns N/A' do
      expect(helper.star_rating('N/A')).to eq 'N/A'
    end

    it 'when passed a number, returns stars' do
      expect(helper.star_rating(4)).to eq "\u2605\u2605\u2605\u2605\u2606"
    end
  end
end
