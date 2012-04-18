module ApplicationHelper
  def page_title title
    return content_tag(:div, :id=>"title") do 
      content_tag(:h3, title) +
      tag(:hr)
    end
  end
end
