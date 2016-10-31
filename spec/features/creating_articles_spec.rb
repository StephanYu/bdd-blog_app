require 'rails_helper'

RSpec.feature 'Create Article' do 
  scenario 'user creates article on index page' do 
    visit root_path
    
    click_link 'Create Article'
    
    fill_in 'Title', with: 'Test Article'
    fill_in 'Body', with: 'A test body'
    
    click_button 'Submit'

    expect(page).to have_content('Article has been created')
    expect(page.current_path).to eq(articles_path)
  end
end