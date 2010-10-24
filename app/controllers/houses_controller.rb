require 'fastercsv'

class HousesController < AdminController
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
          csv << ["Title", "Text", "Comment", "Bottom Text", "Price", "Location", "Number of rooms"]

          @houses.each do |h|
            location = h.location.title unless h.location.nil?
            price = h.price.title unless h.price.nil?
            number = h.number.title unless h.number.nil?

            csv << [h.title, 
              sanitize(h.text), 
              sanitize(h.comment),
              sanitize(h.bottom_text),
              price, 
              location, 
              number]
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

    respond_to do |format|
      if @house.save
        flash[:notice] = 'House was successfully created.'
        format.html { redirect_to houses_path }
        format.xml  { render :xml => @house, :status => :created, :location => @house }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @house.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @house = House.find(params[:id])
  end

  def update
    @house = House.find(params[:id])

    respond_to do |format|
      if @house.update_attributes(params[:house])
        flash[:notice] = 'House was successfully updated.'
        format.html { redirect_to houses_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @house.errors, :status => :unprocessable_entity }
      end
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
    if params[:house_type] == 'rent'
      @houses = House.all(:conditions => ["house_type = 'all' or house_type = 'rent'"])
    else
      @houses = House.all(:conditions => ["house_type = 'sale' or house_type = 'all'"])
    end
    render :partial => "editable_house", :collection => @houses, :locals => {:house_type => params[:house_type]}
  end

  # DELETE /houses/1
  # DELETE /houses/1.xml
  def destroy
    @house = House.find(params[:id])
    @house.destroy

    respond_to do |format|
      format.html { redirect_to(houses_url) }
      format.xml  { head :ok }
    end
  end
end

