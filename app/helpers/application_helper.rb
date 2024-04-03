# frozen_string_literal: true

module ApplicationHelper
  require 'rails_autolink'

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

  def feedback_google_form_url
    "https://docs.google.com/forms/d/e/#{Rails.application.config.x.feedback_google_form_id}/viewform?embedded=true"
  end

  def disable_header
    content_for(:header, tag.header)
  end

  def disable_footer
    content_for(:footer, tag.footer)
  end

  def format_date_to_ymd(time)
    time.strftime('%Y-%m-%d')
  end

  def auto_link_url(text)
    auto_link(text, html: { target: '_blank' }, link: :urls)
  end

  def simple_format_with_link_new(text)
    simple_format(text, {}, { sanitize_options: { attributes: %w[target href] } })
  end
end
