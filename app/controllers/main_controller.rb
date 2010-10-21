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
    get_houses(["rent", "all"])
    @title = @catalog_page.title
  end

  def sale_catalog
    @current_menu = 3
    get_houses(["sale", "all"])
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

  def search
    @houses = House.title_like_or_bottom_text_like_or_comment_like_or_sale_bottom_text_like_or_catalog_title_like(params[:query])
    @articles = Article.title_like_or_body_like(params[:query])
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

    def get_houses(house_types)
      if not params[:query].nil? then
        @query = Query.new(params[:query])
        @houses = House.find_by_query(@query, params[:page], house_types)
      else
        if params[:query].nil?
          @houses = House.find_all_with_paginate(params[:page], "(house_type = '#{house_types[0]}' or house_type = '#{house_types[1]}')")
        else
          @query = Query.new(params[:query])
          @houses = House.find_by_query(@query, params[:page], house_types)
        end
      end
    end

end

