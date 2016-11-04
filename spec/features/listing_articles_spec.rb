require 'rails_helper'

RSpec.feature 'Listing Articles' do 
  before do 
    @user = User.create(email: 'user@email.com', password: 'password')
    @article1 = Article.create(title: 'The first article', body: 'The first article body', user: @user)
    @article2 = Article.create(title: 'The second article', body: 'The second article body', user: @user)
  end

  scenario 'Lists all articles with a non-signed in user' do 
    visit root_path

    expect(page).to have_content(@article1.title) 
    expect(page).to have_content(@article1.body) 
    expect(page).to have_content(@article2.title) 
    expect(page).to have_content(@article2.body) 
    expect(page).to have_link(@article1.title) 
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link('Create Article')
  end

  scenario 'Lists all articles with a signed in user' do 
    login_as(@user)
    visit root_path

    expect(page).to have_content(@article1.title) 
    expect(page).to have_content(@article1.body) 
    expect(page).to have_content(@article2.title) 
    expect(page).to have_content(@article2.body) 
    expect(page).to have_link(@article1.title) 
    expect(page).to have_link(@article2.title)
    expect(page).to have_link('Create Article')
  end

  scenario 'A user has no articles' do 
    Article.delete_all
    
    visit root_path

    expect(page).not_to have_content(@article1.title) 
    expect(page).not_to have_content(@article1.body) 
    expect(page).not_to have_content(@article2.title) 
    expect(page).not_to have_content(@article2.body) 
    expect(page).not_to have_link(@article1.title) 
    expect(page).not_to have_link(@article2.title)
    within ("h1#no-articles") do
      expect(page).to have_content("No Articles Created")
    end 
  end
end