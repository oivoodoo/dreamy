class CreateBeaches < ActiveRecord::Migration
  def self.up
    create_table :beaches do |t|
      t.string :title
      t.integer :search_id

      t.timestamps
    end
  end

  def self.down
    drop_table :beaches
  end
end
