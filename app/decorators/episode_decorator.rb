# frozen_string_literal: true

module EpisodeDecorator
  def pub_date_s
    pub_date.strftime('%Y.%-m.%-d')
  end
end
