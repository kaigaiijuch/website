# frozen_string_literal: true

module ApplicationHelper # rubocop: disable Style/Documentation
  def title(title)
    content_for :title, title
  end

  def yield_title(base_title: Rails.application.config.x.website_title.base)
    if content_for?(:title)
      base_title + Rails.application.config.x.website_title.separator + content_for(:title)
    else
      base_title
    end
  end

  def google_tag_manager_id
    Rails.application.config.x.google_tag_manager_id
  end
end
