class ArticlesController < ApplicationController
  def show
    @article = Article.find_by_name(params[:name]) || Article.find_by_id(params[:name])
    @title = @article.title unless @article.title.nil?
  end
end
