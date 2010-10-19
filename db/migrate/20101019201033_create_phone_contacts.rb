class CreatePhoneContacts < ActiveRecord::Migration
  def self.up
    create_table :phone_contacts do |t|
      t.string :username
      t.string :phone
      t.datetime :time

      t.timestamps
    end
  end

  def self.down
    drop_table :phone_contacts
  end
end
