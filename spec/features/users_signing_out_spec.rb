require 'rails_helper'

RSpec.feature 'User signing out' do 
  before do 
    @user = User.create!(email: 'test@email.com', password: 'password')

    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_button 'Log in'
  end

  scenario 'User logs out successfully' do 
    visit root_path

    click_link 'Sign out'

    expect(page).to have_content('Signed out successfully')
    expect(page).not_to have_link 'Sign out'
  end
end