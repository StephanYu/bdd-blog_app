require 'rails_helper'

RSpec.feature 'Showing an Article' do 
  before do 
    @article = Article.create(title: "A Test Article", body: 'A Test body')
  end
  scenario 'A user clicks on an article to show its details' do 
    visit root_path

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end