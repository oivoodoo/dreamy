class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  filter_parameter_logging :password
  before_filter :render_menu, :get_header, :get_footer
  skip_after_filter :add_google_analytics_code

  attr_reader :current_user

protected
  def login_required
    if @current_user.nil?
      @current_user = User.find(session[:user_id]) unless session[:user_id].nil?
    end
  end

  def eval_json(json)
    value = json
    value = value.gsub(':', '=>')
    value = value.gsub('http=>', 'http:')
    value = value.gsub('null', '""')
    eval(value)
  end

  def render_menu
    @main_menus ||= MainMenu.find(:all, :order => "position")
    @banners ||= Banner.find(:all, :order => "created_at")
    true
  end

  def get_header
    @header = Header.first
  end

  def get_footer
    @footer = Footer.first
  end
end

