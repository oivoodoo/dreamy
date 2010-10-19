class CreatePhoneContactsPages < ActiveRecord::Migration
  def self.up
    create_table :phone_contacts_pages do |t|
      t.string :title
      t.string :meta_keywords
      t.string :meta_description
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :phone_contacts_pages
  end
end
