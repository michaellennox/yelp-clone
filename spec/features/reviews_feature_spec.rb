require 'rails_helper'

feature 'reviews' do
  context 'while user is signed in' do
    before(:each) do
      sign_up
      create_restaurant
    end

    scenario 'a user should be able to leave a review via a form' do
      leave_review
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('so so')
    end

    scenario 'a user should not be able to review multiple times' do
      leave_review
      leave_review(thoughts: 'epicsauce')
      expect(page).not_to have_content 'epicsauce'
      expect(page).to have_content 'You cannot review the same restaurant more than once'
    end

    scenario 'a user should be able to delete their own review' do
      leave_review
      click_link 'KFC'
      click_link 'Delete Review'
      expect(page).not_to have_content 'so so'
      expect(page).to have_content 'Review deleted successfully'
    end
  end

  context 'while user is not signed in' do
    before(:each) do
      kfc = Restaurant.create(name: 'KFC')
      Review.create(restaurant: kfc, rating: 5)
    end

    scenario 'a user should not be able to leave a review' do
      visit '/restaurants'
      click_link 'Review KFC'
      expect(current_path).to eq '/users/sign_in'
    end

    scenario 'the delete button should not be visible on a review' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).not_to have_link 'Delete Review'
    end
  end
end
