class OrderMailer < ActionMailer::Base
  def order_notification(order)
    @@smtp_settings = {
      :enable_starttls_auto => true,
      :address              => "smtp.gmail.com",
      :port                 => "587",
      :domain               => "",
      :authentication       => :plain,
      :user_name            => "korsak@dreamydays.ru",
      :password             => "111111"
    }

		recipients "peskova@dreamydays.ru"
		from "dreamydays.contacts@gmail.com"
		subject "Получены новые данные на странице контакты"
		content_type "text/html"
		sent_on Time.now
		body :order => order
  end

  def phone_contact_notification(contacts)
    @@smtp_settings = {
      :enable_starttls_auto => true,
      :address              => "smtp.gmail.com",
      :port                 => "587",
      :domain               => "",
      :authentication       => :plain,
      :user_name            => "korsak@dreamydays.ru",
      :password             => "111111"
    }

		recipients "peskova@dreamydays.ru"
		from "dreamydays.contacts@gmail.com"
		subject "Получены новые данные на странице 'мы вам перезвоним'"
		content_type "text/html"
		sent_on Time.now
		body :contacts => contacts
  end
end

