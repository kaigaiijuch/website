# frozen_string_literal: true

module ApplicationHelper
  def google_tag_manager_id
    Rails.application.config.x.google_tag_manager_id
  end

  def feedback_google_form_url
    "https://docs.google.com/forms/d/e/#{Rails.application.config.x.feedback_google_form_id}/viewform?embedded=true"
  end

  def feedback_typeform_embed_tag
    [
      tag.div(data: { tf_live: Rails.application.config.x.feedback_typeform_id }),
      tag.script(src: '//embed.typeform.com/next/embed.js')
    ].join
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

  def image_url_with_host(path)
    image_url(path, host: Rails.application.config.x.website_uri.to_s)
  end
end
