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

  scenario 'a user should not be able to review multiple times' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'

    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'epicsauce'
    select '5', from: 'Rating'
    click_button 'Leave Review'

    expect(page).not_to have_content 'epicsauce'
    expect(page).to have_content 'You cannot review the same restaurant more than once'
  end
end
