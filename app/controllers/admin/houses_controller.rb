require 'fastercsv'
require 'rubygems'
require 'sanitize'

class Admin::HousesController < Admin::AdminController

  layout "admin"
  uses_tiny_mce(:options => AppConfig.default_mce_options, :only => [:new, :edit])
  skip_before_filter :verify_authenticity_token, :only => [:update_positions, :update_container]

  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::TextHelper

  def index
    
  end

  def index_rent
    @houses_rent = House.house_type_name_equals(["rent", "all"]).paginate :page => params[:page]
  end

  def index_sale
    @houses_sale = House.house_type_name_equals(["sale", "all"]).paginate :page => params[:page]
  end

  def show
    @house = House.find(params[:id])
    @menus = HouseMenu.find(:all)
  end

  def new
    @house = House.new
  end

  def export
    @houses = House.all

    respond_to do |format|
      format.html
      format.xml {render :layout => false}
      format.rss {render :layout => false}
      format.csv do
        csv_string = FasterCSV.generate do |csv|
          csv << ["Title", 
            "Text", 
            "Comment", 
            "Bottom Text", 
            "Total price", 
            "Price", 
            "Location", 
            "Number of rooms", 
            "House type", 
            "Catalog title", 
            "Special offer", 
            "High Duration(first period)", 
            "Cost day", 
            "Cost week", 
            "Const month", 
            "High Duration(second period)", 
            "Low Duration(first period)",
            "Cost day",
            "Cost week",
            "Cost month",
            "Low duration(second period)"]

          @houses.each do |h|
            location = h.location.title unless h.location.nil?
            price = h.price.title unless h.price.nil?
            number = h.number.title unless h.number.nil?

            csv << [h.title, 
              Sanitize.clean(h.text).gsub(/&#13;/, ""), 
              Sanitize.clean(h.comment).gsub(/&#13;/, ""),
              Sanitize.clean(h.bottom_text).gsub(/&#13;/, ""),
              Sanitize.clean(h.total_price).gsub(/&#13;/, ""),
              price, 
              location, 
              number,
              h.house_type.title,
              h.catalog_title,
              h.special_offer,
              h.high_duration_1,
              h.high_cost_day,
              h.high_cost_week,
              h.high_cost_month,
              h.high_duration_2,
              h.low_duration_1,
              h.low_cost_day,
              h.low_cost_week,
              h.low_cost_month,
              h.low_duration_2]
          end
        end

        filename = "export.csv"
        send_data(csv_string,
                  :type => 'text/csv; charset=utf-8; header=present',
                  :filename => filename)    
      end
    end
  end

  def create
    @house = House.new(params[:house])
    @house.house_container_id = HouseContainer.first.id

    if @house.save
      flash[:notice] = 'House was successfully created.'
      redirect_to houses_path
    else
      render :action => "new"
    end
  end

  def edit
    @house = House.find(params[:id])
  end

  def update
    @house = House.find(params[:id])
    if @house.update_attributes(params[:house])
      flash[:notice] = 'House was successfully updated.'
      redirect_to houses_path
    else
      render :action => "edit"
    end
  end

  def update_positions
    values = eval_json(params[:values])
    values.uniq.each do |v|
      House.find(v['id'].to_i).update_attributes(:group_position => v['value'].to_i)
    end
    render :text => ""
  end

  def update_container
    params[:page] = 1 if params[:page].to_i <= 0
    if params[:house_type] == 'rent'
      @houses = House.house_type_name_equals(['all', 'rent']).paginate(:page => params[:page])
    else
      @houses = House.house_type_name_equals(['all', 'sale']).paginate(:page => params[:page])
    end
    render :partial => "editable_house", :collection => @houses, :locals => {:house_type => params[:house_type]}
  end

  def destroy
    @house = House.find(params[:id])
    @house.destroy
    redirect_to(houses_url)
  end

end
