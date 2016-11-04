require 'rails_helper'

RSpec.feature 'Showing an Article' do 
  before do 
    @adam = User.create(email: 'adam@email.com', password: 'password')
    @eve = User.create(email: 'eve@email.com', password: 'password')
    @article = Article.create(title: 'A test article', body: 'A test body', user: @adam)
  end

  scenario 'A user clicks on an article to show its details' do 
    visit root_path

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end

  scenario 'A Non-signed in user cannot see the Edit and Delete button' do 
    visit root_path

    click_link @article.title
    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
  end

  scenario 'A Non-owner user cannot see the Edit and Delete button' do 
    login_as(@eve)
    visit root_path

    click_link @article.title
    expect(page).not_to have_link('Edit Article')
    expect(page).not_to have_link('Delete Article')
  end

  scenario 'A Signed-in Owner sees the Edit and Delete button' do 
    login_as(@adam)
    visit root_path

    click_link @article.title
    expect(page).to have_link('Edit Article')
    expect(page).to have_link('Delete Article')
  end
end