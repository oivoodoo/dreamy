ActionController::Routing::Routes.draw do |map|
  map.resources :houses, :only => [:show]

  map.namespace :admin do |admin|
    admin.root :controller => "admin"
    admin.resources :users, :members => {:logout => :get, :change_password => :get, :do_change_password => :put} 
    admin.resources :session
    admin.new_session '/admin/new_session', :controller => "admin", :action => "new_session"
    admin.login '/login', :controller => "admin", :action => "login"
    admin.base_page '/base_page', :controller => "base_page", :action => "index"
    admin.resources :conditions
    admin.resources :main_menus
    admin.resources :house_menus
    admin.resources :searches
    admin.resources :sale_searches
    admin.resources :banners
    admin.resources :articles
    admin.resources :contacts, :only => [:index, :destroy]
    admin.resources :phone_contacts, :only => [:index, :destroy]
    admin.resources :assets, :only => [:new, :create, :index, :show]
    admin.resources :houses, :member => {:update_positions => :post, :update_container => :post, :export => :get, :rent => :get, :sale => :get}
    admin.index_rent '/h/index_rent', :controller => "houses", :action => "index_rent"
    admin.index_sale '/h/index_sale', :controller => "houses", :action => "index_sale"
    admin.connect ':controller/:action/:id'
    admin.connect ':controller/:action/:id.:format'
  end

  map.root :controller => 'main', :action => 'index'
  map.connect '', :controller => 'main', :action => 'index'
  map.connect '/index.:format', :controller => 'main', :action => "index"

  map.about '/about', :controller => "main", :action => "about"
  map.services '/services', :controller => "main", :action => "services"
  map.travelling '/travelling', :controller => "main", :action => "travelling"
  map.catalog '/catalog', :controller => "main", :action => "catalog"
  map.contacts '/contacts', :controller => "main", :action => "contacts"
  map.send_contacts '/send_contacts', :controller => "main", :action => "send_contacts", :conditions => {:method => :post}
  map.send_phone_contacts '/send_phone_contacts', :controller => "main", :action => "send_phone_contacts", :conditions => {:method => :post}
  map.search '/search', :controller => "main", :action => "search"
  map.export_rss '/export.:format', :controller => "houses", :action => "export"
  map.feed '/feed.:format', :controller => "main", :action => "feed"
  
  map.article '/:name', :controller => "main", :action => "show_article"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
