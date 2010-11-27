class Admin::SearchesController < Admin::AdminController
  layout "admin"

  def edit
    @search = Search.find(:first)
  end
  
  def update
    @search = Search.find(params[:id])

    if @search.update_attributes(params[:search])
      flash[:notice] = 'House was successfully updated.'
      redirect_to :controller => :admin, :action => :index      
    else
      render :controller => :admin, :action => :index      
    end
  end
end
