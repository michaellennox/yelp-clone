require 'rails_helper'

feature 'endorsements' do
  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'Mmmmmmmmm')
  end

  scenario 'a user can endorse a review, increasing it\'s endorsement count' do
    visit '/restaurants'
    click_link 'KFC'
    click_link 'Endorse Review'
    expect(page).to have_content 'Endorsements: 1'
  end
end
