require 'rails_helper'

RSpec.describe 'Articles', type: :request do 
  before do
    @adam = User.create(email: 'adam@email.com', password: 'password')
    @eve = User.create(email: 'eve@email.com', password: 'password')
    @article = Article.create!(title: 'A test article', body: 'A test body', user: @adam)
  end

  describe 'GET/articles/:id/edit' do 

    context 'with a non-signed in user' do 
      it 'redirects to the signin page' do 
        get "/articles/#{@article.id}/edit"

        expect(response.status).to eq 302
        message = 'You need to sign in or sign up before continuing.'
        expect(flash[:alert]).to eq message
      end
    end

    context 'with a signed in user who is a non-owner' do
      it 'redirects to the home page' do 
        login_as(@eve)
        get "/articles/#{@article.id}/edit"

        expect(response.status).to eq 302
        message = "You can only edit your own article."
        expect(flash[:alert]).to eq message
      end
    end

    context 'with a signed in user who is an owner' do 
      it 'successfully directs to the edit page' do 
        login_as(@adam)
        get "/articles/#{@article.id}/edit"
        
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET/articles/:id' do 
    context 'with an existing article' do 
      it 'handles the article' do
        get "/articles/#{@article.id}"

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