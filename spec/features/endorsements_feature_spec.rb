require 'rails_helper'

feature 'endorsing reviews' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'It was an abomination')
  end

  scenario 'a user can endorse a review, which increments the endorsement count', js: :true do
    visit '/restaurants'
    expect(page).to have_content('0 endorsements')
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

end
