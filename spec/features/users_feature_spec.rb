require 'rails_helper'

feature 'User' do
  context 'when not signed in and on the homepage' do
    it 'should see a sign in and a sign up link' do
      visit '/'
      expect(page).to have_link 'Sign in'
      expect(page).to have_link 'Sign up'
    end

    it 'should not see sign out link' do
      visit '/'
      expect(page).not_to have_link 'Sign out'
    end
  end

  context 'when signed in on the hompage' do
    before(:each) { sign_up }

    it 'should see sign out link' do
      visit '/'
      expect(page).to have_link 'Sign out'
    end

    it 'should not see a sign in link or a sign up link' do
      visit '/'
      expect(page).not_to have_link 'Sign in'
      expect(page).not_to have_link 'Sign up'
    end
  end
end
