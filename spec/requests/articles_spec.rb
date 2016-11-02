require 'rails_helper'

RSpec.describe 'Articles', type: :request do 
  before do
    @article = Article.create(title: "Title one", body: "Body of article one")
  end

  describe 'GET/articles/:id' do 

    context 'with an existing article' do 
      it 'handles the article' do
        get '/articles/#{@article.id}'

        expect(response.status).to eq 200
      end 
    end

    context 'with a non-existing article' do 
      it 'handles the article' do
        get '/articles/xxx'

        expect(response.status).to eq 302
        message = "The article you are looking for could not be found"
        expect(flash[:alert]).to eq message
      end 
    end
  end
end