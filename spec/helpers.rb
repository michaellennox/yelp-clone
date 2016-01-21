module Helpers
  def sign_up
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'testtest'
    fill_in 'Password confirmation', with: 'testtest'
    click_button 'Sign up'
  end

  def create_restaurant
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
  end

  def leave_review(restaurant: 'KFC', thoughts: 'so so', rating: 3)
    visit '/restaurants'
    click_link "Review #{restaurant}"
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end
end
