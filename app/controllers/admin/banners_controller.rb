class Admin::BannersController < Admin::AdminController

  def index
    @banners = Banner.all
  end

  def show
    @banner = Banner.find(params[:id])
  end

  def new
    @banner = Banner.new
  end

  def create
    @banner = Banner.new(params[:banner])

    respond_to do |format|
      if @banner.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to([:admin, @banner]) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @banner = Banner.find(params[:id])
    @banner.destroy
    redirect_to(admin_banners_url)
  end
end
