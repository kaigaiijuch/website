module ApplicationHelper
  def set_title(title)
    @title = title
  end

  def title
    @title.blank? ? BASE_TITLE : "#{BASE_TITLE}:#{@title}"
  end

  BASE_TITLE = "海外移住channel"
end
