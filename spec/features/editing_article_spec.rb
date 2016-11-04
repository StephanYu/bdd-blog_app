require 'rails_helper'

RSpec.feature 'Editing Article' do 
  before do 
    @user = User.create(email: 'user@email.com', password: 'password')
    login_as(@user)
    @article = Article.create(title: 'A test article', body: 'A test body', user: @user)
  end

  scenario 'A user updates an article' do 
    visit root_path

    click_link @article.title
    click_link 'Edit Article'

    fill_in 'Title', with: 'An updated Article'
    fill_in 'Body', with: 'An updated Body'

    click_button 'Update Article'

    expect(page).to have_content('Article has been successfully updated')
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario 'A user fails to update an article' do 
    visit root_path

    click_link @article.title
    click_link 'Edit Article'

    fill_in 'Title', with: ''
    fill_in 'Body', with: ''

    click_button 'Update Article'

    expect(page).to have_content('Article has not been updated')
    expect(page.current_path).to eq(article_path(@article))
  end
end