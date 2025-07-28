# frozen_string_literal: true

xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0', 'xmlns:atom': 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title t('site.name')
    xml.description t('site.description')
    xml.link root_url
    xml.tag!('atom:link', href: episodes_url(format: :rss), rel: 'self', type: 'application/rss+xml')

    @episodes.each do |episode|
      xml.item do
        xml.title episode.title
        disable_annotate_rendered_view_with_filenames do
          xml.description(render(partial: 'descriptions/episodes/description', locals: { episode: }, formats: :html))
        end
        xml.image image_url_with_host(episode.image_path)
        xml.logo_image cl_image_path(
          ENV.fetch('CLOUDINARY_STORY_IMAGE'),
          transformation: [
            # (remote) image overlay
            { overlay: { url: image_url_with_host(episode.image_path) } },
            { width: 700, crop: 'scale' },
            { flags: 'layer_apply', gravity: 'north', y: 150 },
            # text overlay
            { overlay: {
                font_family: 'TakaoExGothic', font_size: 60, text_align: 'center', text: episode.title
              },
              width: 750, crop: 'fit' },
            { flags: 'layer_apply', gravity: 'center', y: 330 }
          ]
        )

        xml.pubDate episode.published_at.rfc822
        xml.link episode_url(episode)
        xml.guid episode_url(episode)
      end
    end
  end
end
