class Admin::ArticlesController < Admin::AdminController
  layout "admin"
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit])

  def index
    @articles = Article.find(:all)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params[:article])

    if @article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to [:admin, @article]
    else
      render :action => "new"
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update_attributes(params[:article])
      flash[:notice] = 'Article was successfully updated.'
      redirect_to [:admin, @article]
    else
      render :action => "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_url
  end
end
