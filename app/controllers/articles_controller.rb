class ArticlesController < ApplicationController
  def index
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params) 
    if @article.save
      flash[:success] = "Article has been created" 
      redirect_to articles_path
    else 
      flash[:error] = "There has been an error saving the article"
      redirect_to new_articles_path
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
