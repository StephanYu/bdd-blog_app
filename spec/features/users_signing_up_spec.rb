require 'rails_helper'

RSpec.feature 'Users signup' do 
  scenario 'with valid credentials' do 
    visit root_path
    
    click_link 'Sign up'

    fill_in 'Email', with: 'user@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'with invalid credentials' do 
    visit root_path
    
    click_link 'Sign up'

    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''

    click_button 'Sign up'

    expect(page).to have_content('2 errors prohibited this user from being saved:')
    expect(page).to have_content('Email can\'t be blank')
    expect(page).to have_content('Password can\'t be blank')
  end
end
