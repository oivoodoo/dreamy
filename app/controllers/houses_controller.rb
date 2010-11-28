class HousesController < ApplicationController 
  
   def show
     @house = House.find(params[:id])
   end

end

