# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def navigation_item(current, preff, &block)
    if current == preff then
        content_tag :li, yield, :id => "current"
    else
        content_tag :li, yield
    end
  end
  
  def shadow_frame(class_add = "", &block)
    concat("<div class=\"framed\">
            <div class=\"f_tt\"></div>
            <div class=\"f_r\">
            <div class=\"f_rr\"></div>
            <div class=\"f_b\">
            <div class=\"f_bb\">
            <div></div>
            </div><div class=\"f_l\">
            <div class=\"f_ll\"><div></div>
            </div><div class=\"f_c\">", block.binding)
    yield
    concat("</div></div></div></div></div>", block.binding)
  end
  
  def house_title(house)
    "<b style=\"color: red; margin-right: 10px;\">#{house.special_offer}</b>#{house.title}"
  end
  
  def house_title_link(house)
    "<a href=\"#{url_for(house_path(:id => house.id))}\">
      #{house_title(house)}<span style=\"color: #999999; \">&#187</span></a>"
  end
  
  def google_analytics(code)
     %(
         <script type='text/javascript'>
           var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
           document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
           try {
           var pageTracker = _gat._getTracker("#{code}");
           pageTracker._trackPageview();
           } catch(err){}
         </script>
       )
   end  

  def render_template_form(template, action_name)
    render :partial => template, :locals => {:action_name => action_name}
  end

  def generate_html(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize
    options[:form_builder_local] ||= :f

    form_builder.fields_for(method, options[:object], :child_index => 'NEW_RECORD') do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end

  def generate_template(form_builder, method, options = {})
    escape_javascript generate_html(form_builder, method, options = {})
  end

  def remove_link_unless_new_record(fields, options = {})
    out = ''
    out << fields.hidden_field(:_delete)  unless fields.object.new_record?
    out << link_to("удалить", "##{options[:class_name].nil? ? fields.object.class.name.underscore : options[:class_name]}", :class => 'remove')
    out
  end

  def add_link(title, model, rel = model.pluralize)
    link_to title, "##{model}", :class => "add_nested_item", :rel => rel
  end
end
