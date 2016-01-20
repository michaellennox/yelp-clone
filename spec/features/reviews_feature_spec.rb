require 'rails_helper'

feature 'reviews' do
  before(:each) { Restaurant.create(name: 'KFC') }

  scenario 'a user should be able to leave a review via a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end
end
