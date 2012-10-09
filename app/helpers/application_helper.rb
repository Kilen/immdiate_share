module ApplicationHelper
  def page_title title
    return content_tag(:div, :id=>"header") do 
      render(:partial => "shared/flash_info") +
      content_tag(:div, title, :class=>"title") +
      content_tag(:div, :class=>"share_button") do
        link_to("new share", new_share_info_path,:class=>"large nice black button radius" )
      end +
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
  def my_video_tag(url,option={})
    width = option["width"] || "540px"
    height = option["height"] || "450px"
    return "<embed src=#{url} type='application/x-shockwave-flash' allowscriptacess='always' allowfullscreen='true' style='width:#{width};height:#{height};' ></embed>".html_safe
  end
end
