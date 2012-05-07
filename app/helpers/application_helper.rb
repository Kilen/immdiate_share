module ApplicationHelper
  def page_title title
    return content_tag(:div, :id=>"title") do 
      content_tag(:h3, title) +
      tag(:hr)
    end
  end
  def menu_item_available_if condition, text, path
    if condition
      html = "<li>"
    else
      html = "<li class=\"unavailable\">"
    end
    html << link_to(text,path)
    html << "</li>"
    return html.html_safe
  end
end
