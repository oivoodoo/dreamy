class Admin::AssetsController < Admin::AdminController

  def index
    @assets = Asset.all
  end

  def show
    @asset = Asset.find(params[:id])
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(params[:asset])
    @asset.save

    redirect_to :action => :index
  end

  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy
  end
end
