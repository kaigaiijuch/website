# frozen_string_literal: true

module ApplicationHelper # rubocop: disable Style/Documentation
  def set_title(title)
    @_title = title
  end

  def title
    if @_title.blank?
      Rails.application.config.x.website_title.base
    else
      Rails.application.config.x.website_title.base + Rails.application.config.x.website_title.separator + @_title
    end
  end

  def google_tag_manager_id
    Rails.application.config.x.google_tag_manager_id
  end
end
