class HousesController < ApplicationController 
  
   def show
     @house = House.find(params[:id])
     @menus = HouseMenu.find(:all, :order => "position")
     @current_menu = 1
   end

end

