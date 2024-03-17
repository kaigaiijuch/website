# frozen_string_literal: true

module ApplicationHelper # rubocop: disable Style/Documentation
  def title(title)
    content_for :title, title
  end

  def yield_title(base_title: Rails.application.config.x.website_title.base,
                  separator: Rails.application.config.x.website_title.separator)
    [base_title, content_for(:title)].compact.join(separator)
  end

  def google_tag_manager_id
    Rails.application.config.x.google_tag_manager_id
  end
end
