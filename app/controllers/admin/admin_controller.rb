module Admin ; end

class Admin::AdminController < ApplicationController
  before_filter :authenticate, :except => %w(login new_session)
  before_filter :find_search
  
  layout "admin"

  def index
  end

  def login 
  end

  def new_session
    user = User.authenticate(params[:name], params[:password])
    if user.nil?
     redirect_to :controller => "admin", :action => "login" 
    else 
      session[:user_id] = user.id
      redirect_to :controller => "admin", :action => 'index' 
    end
  end

 private
  def authenticate
   if session[:user_id].nil?
     redirect_to :controller => "admin", :action => "login" 
   end
  end

  def find_search
    @search = Search.first
  end
end
