require 'rails_helper'

RSpec.feature 'Create Article' do 
  scenario 'user creates article on index page' do 
    visit root_path
    
    click_link 'Create Article'
    
    fill_in 'Title', with: 'Test Article'
    fill_in 'Body', with: 'A test body'
    
    click_button 'Create Article'

    expect(page).to have_content('Article has been created')
    expect(page.current_path).to eq(articles_path)
  end

  scenario 'user fails to create a new article' do 
    visit root_path

    click_link 'Create Article'
    
    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    
    click_button 'Create Article'

    expect(page).to have_content('Article has not been created')
    expect(page).to have_content('Title can\'t be blank')
    expect(page).to have_content('Body can\'t be blank')
  end
end