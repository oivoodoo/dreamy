class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  protect_from_forgery # :secret => '65468990f1f6b46db26e44a55135998c'
  before_filter :render_menu
  
  def render_menu
    @main_menus ||= MainMenu.find(:all, :order => "position")
    @banners ||= Banner.find(:all, :order => "created_at")
    true
  end
end
