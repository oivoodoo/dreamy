class ClearFooter < ActiveRecord::Migration
  def self.up
    Footer.first.update_attributes({:content => ""}) 
    MainPage.first.update_attributes({:right_bottom_content => ""})
  end

  def self.down

  end
end
