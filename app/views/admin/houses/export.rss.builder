xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Dreamydays.ru"
    xml.description "Dreamydays"
    xml.link "http://www.dreamydays.ru/"

    for h in @houses
      xml.item do
        xml.title h.title
        xml.description h.text
        xml.pubDate h.created_at.to_s(:rfc822)
        unless h.house_type.nil?
          xml.link url_for(:controller => "main", :action => "show_house", :house_type => h.house_type.name)
        else
          xml.link url_for(:controller => "main", :action => "show_house")
        end
      end
    end
  end
end
