require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  before do 
    @adam = User.create(email: 'adam@email.com', password: 'password')
    @eve = User.create(email: 'eve@email.com', password: 'password')
    @article = Article.create(title: 'A test article', body: 'A test body', user: @adam)
  end

  describe 'POST /articles/:id/comments' do 
    context 'as a non-signed in user' do 
      it 'redirects to the signin page' do 
        post "/articles/#{@article.id}/comments", params: { comment: { body: 'A great comment' } }

        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302

        message = 'Please sign in or sign up first'
        expect(flash[:alert]).to eq message
      end
    end

    context 'as a signed in user' do 
      it 'successfully posts a comment' do 
        login_as(@eve)
        post "/articles/#{@article.id}/comments", params: { comment: { body: 'A great comment' } }

        expect(response).to redirect_to(article_path(@article.id))
        expect(response.status).to eq 302

        message = 'Comment was successfully created'
        expect(flash[:notice]).to eq message
      end
    end
  end
end