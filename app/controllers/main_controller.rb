class MainController < ApplicationController
  before_filter :prepare_catalog_page, :only => %w(catalog sale_catalog)
  before_filter :get_search, :only => %w(index catalog)
  before_filter :get_sale_search, :only => %w(sale_catalog)

  def index
    @current_menu = 0

    @query = Query.new
    @house = House.find_main
    @main_photo = House.find_main_photo
    @main_page = MainPage.find(:first)

    @title = @main_page.title
  end

  def contacts
    @current_menu = 6
    @contacts_page = ContactsPage.find(:first)
    @title = @contacts_page.title
  end

  def about
    @current_menu = 3
    @about_page = AboutPage.find(:first)
    @title = @about_page.title
  end

  def services
    @current_menu = 2
    @services_page = ServicesPage.find(:first)
  end

  def travelling
    @current_menu = 4
    @travelling_page = TravellingPage.find(:first)
    @title = @travelling_page.title
  end

  def catalog
    @current_menu = 1
    if not params[:query].nil? then
      @query = Query.new(params[:query])
      @houses = House.find_by_query(@query, params[:page], "(house_type = 'rent' or house_type = 'all')")
      session[:query] = params[:query]
    else
      if session[:query].nil? 
      @houses = House.find_all_with_paginate(params[:page], "(house_type = 'rent' or house_type = 'all')")
      else 
       @query = Query.new(session[:query])
       @houses = House.find_by_query(@query, params[:page], "(house_type = 'rent' or house_type = 'all')")
      end 
    end
    @title = @catalog_page.title
  end

  def sale_catalog
    if not params[:query].nil? then
      @query = Query.new(params[:query])
      @houses = House.find_by_query(@query, params[:page], "(house_type = 'sale' or house_type = 'all')")
      session[:query] = params[:query]
    else
      if session[:query].nil?
        @houses = House.find_all_with_paginate(params[:page], "(house_type = 'sale' or house_type = 'all')")
      else
       @query = Query.new(session[:query])
       @houses = House.find_by_query(@query, params[:page], "(house_type = 'sale' or house_type = 'all')")
      end
    end
    @title = @sale_page.title
  end

  def show_house
    @house = House.find(params[:id])
    @menus = HouseMenu.find(:all, :order => "position")
    @current_menu = 1
  end

  def show_article
    @article = Article.find(params[:id])
    @title = @article.title unless @article.title.nil?
  end

  def send_contacts
    contact = Contact.new(params[:contacts])
    contact.save
    OrderMailer.deliver_order_notification(params[:contacts])
    flash[:success] = "Сообщение успешно отправлено."
    redirect_to :action => "contacts"
  end

  def phone_contacts
    @current_menu = 6
    @contacts_page = PhoneContactsPage.find(:first)
    @title = @contacts_page.title
  end

  def send_phone_contacts
    contact = PhoneContact.new(params[:phone_contacts])
    contact.save
    OrderMailer.deliver_phone_contact_notification(params[:phone_contacts])
    flash[:success] = "Сообщение успешно отправлено."
    redirect_to :action => "phone_contacts"
  end

  protected
    def prepare_catalog_page
      @current_menu = 1
      @catalog_page = CatalogPage.first
      @sale_page = SalePage.first
    end

    def get_search
      @search = Search.first
    end

    def get_sale_search
      @sale_search = Search.first
    end
end

