require 'rails_helper'

RSpec.feature 'Showing an Article' do 
  before do 
    @user = User.create(email: 'user@email.com', password: 'password')
    login_as(@user)
    @article = Article.create(title: 'A test article', body: 'A test body', user: @user)
  end
  scenario 'A user clicks on an article to show its details' do 
    visit root_path

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end