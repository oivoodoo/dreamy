class Admin::HouseMenusController < Admin::AdminController

  layout "admin"

  def index
    @house_menus = HouseMenu.find(:all)
  end

  def show
    @house_menu = HouseMenu.find(params[:id])
  end

  def new
    @house_menu = HouseMenu.new
  end
  
  def edit
    @house_menu = HouseMenu.find(params[:id])
  end

  def create
    @house_menu = HouseMenu.new(params[:house_menu])

    if @house_menu.save
      flash[:notice] = 'HouseMenu was successfully created.'
      redirect_to([:admin, @house_menu])
    else
      render :action => "new"
    end
  end

  def update
    @house_menu = HouseMenu.find(params[:id])

    if @house_menu.update_attributes(params[:house_menu])
      flash[:notice] = 'HouseMenu was successfully updated.'
      redirect_to([:admin, @house_menu])
    else
      render :action => "edit"
    end
  end

  def destroy
    @house_menu = HouseMenu.find(params[:id])
    @house_menu.destroy

    redirect_to(admin_house_menus_url)
  end
end

