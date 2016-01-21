require 'rails_helper'

feature 'endorsements' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'Mmmmmmmmm')
  end

  scenario 'the number of endrosements should be visible' do
    visit '/restaurants'
    click_link 'KFC'
    expect(page).to have_content '0 endorsements'
  end

  scenario 'a user can endorse a review, increasing it\'s endorsement count' do
    visit '/restaurants'
    click_link 'KFC'
    click_link 'Endorse Review'
    expect(page).to have_content '1 endorsement'
  end
end
