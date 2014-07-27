module ApplicationHelper
  def nav_li name, url
    is_active = (request.path == url ? 'active' :nil)
    content_tag :li, link_to(name, url), class: is_active
  end
  def page_li page_number
    is_active = (params[:p].to_i == page_number ? 'active' :nil)
    content_tag :li, class: is_active do
      link_to page_number, products_path(p: page_number)
    end
  end
end
