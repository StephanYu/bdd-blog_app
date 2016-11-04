require 'rails_helper'

RSpec.feature 'Delete Article' do 
  before do 
    @user = User.create(email: 'user@email.com', password: 'password')
    login_as(@user)
    @article = Article.create(title: 'A test article', body: 'A test body', user: @user)
  end

  scenario 'A user deletes an article' do 
    visit root_path

    click_link @article.title
    click_link 'Delete Article'

    expect(page).to have_content('Article has been deleted')
    expect(page.current_path).to eq(articles_path)
  end
end