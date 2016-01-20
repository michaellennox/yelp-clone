require 'rails_helper'

feature 'restaurants' do
  context 'when no restaurants have been added' do
    scenario 'the page should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'when a restaurant has been added' do
    let!(:kfc) { Restaurant.create(name: 'KFC') }

    scenario 'a user should see the restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'No restaurants yet'
    end

    scenario 'a user should be able to view further detail about a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end

    context 'when a user is not signed in' do
      scenario 'a user should not be able to edit a restaurant' do
        visit '/restaurants'
        click_link 'Edit KFC'
        expect(current_path).to eq '/users/sign_in'
      end

      scenario 'a user should not be able to create a restaurant' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        expect(current_path).to eq '/users/sign_in'
      end

      scenario 'a user should not be able to delete a restaurant' do
        visit '/restaurants'
        click_link 'Delete KFC'
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  context 'when a user is signed in' do
    before(:each) { sign_up }

    context 'when a user has created a restaurant' do
      before(:each) { create_restaurant }

      scenario 'a user should be able to edit a restaurant' do
        visit '/restaurants'
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        click_button 'Update Restaurant'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(current_path).to eq '/restaurants'
      end

      scenario 'a user should be able to delete a restaurant' do
        visit '/restaurants'
        click_link 'Delete KFC'
        expect(page).not_to have_content 'KFC'
        expect(page).to have_content 'Restaurant deleted successfully'
      end
    end

    scenario 'a user should be able to create a new restaurant' do
      create_restaurant
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'a user should not be able to create a restaurant with a short name' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end

    context 'when a different user created a restaurant' do
      let!(:kfc) { Restaurant.create(name: 'KFC') }

      xscenario 'a user should not be able to edit a restaurant' do
        visit '/restaurants'
        click_link 'Edit KFC'
        fill_in 'Name', with: 'Kentucky Fried Chicken'
        click_button 'Update Restaurant'
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(current_path).to eq '/restaurants'
      end

      xscenario 'a user should not be able to delete a restaurant' do
        visit '/restaurants'
        click_link 'Delete KFC'
        expect(page).not_to have_content 'KFC'
        expect(page).to have_content 'Restaurant deleted successfully'
      end
    end
  end
end
