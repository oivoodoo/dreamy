class Admin::ArticlesController < Admin::AdminController
  layout "admin"
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit])

  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.find(:all)
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article])

    if @article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to [:admin, @article]
    else
      render :action => "new"
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])

    if @article.update_attributes(params[:article])
      flash[:notice] = 'Article was successfully updated.'
      redirect_to [:admin, @article]
    else
      render :action => "edit"
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_url
  end
end
