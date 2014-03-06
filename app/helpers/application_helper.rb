module ApplicationHelper
  def full_title(page_title)
    base_title = "MyCar"
    if page_title.empty?
      "#{base_title}, forum for car lovers"
    else
      "#{page_title} | #{base_title}"
    end
  end
end
