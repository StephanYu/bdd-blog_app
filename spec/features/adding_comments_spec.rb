require 'rails_helper'

RSpec.feature 'Adding Comments to Article' do 
  before do 
    @adam = User.create(email: 'adam@email.com', password: 'password')
    @eve = User.create(email: 'eve@email.com', password: 'password')
    @article = Article.create(title: 'A test article', body: 'A test body', user: @adam)
  end

  scenario 'permit signed in user to leave a comment' do 
    login_as(@eve)

    visit root_path
    click_link @article.title

    fill_in 'New Comment', with: 'Amazing article'
    click_button 'Create Comment'

    expect(page).to have_content('Comment was successfully created')
    expect(page).to have_content('Amazing article')
    expect(current_path).to eq(article_path(@article.id))
  end
end