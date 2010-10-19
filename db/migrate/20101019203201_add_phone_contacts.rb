class AddPhoneContacts < ActiveRecord::Migration
  def self.up
    PhoneContactsPage.create :title => "Услуга 'Мы сами перезвоним!'",
      :body => "Пожалуйста, заполните этот запрос и в удобное для вас время мы вам перезвоним и с радостью ответим на все ваши вопросы!"
  end

  def self.down
  end
end
