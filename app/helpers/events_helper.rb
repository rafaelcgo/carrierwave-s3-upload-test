module EventsHelper
  def download_photos_btn(event, options = {})
    options[:class] ||= 'btn btn-primary'
    link_to '#', class: options[:class] do
      concat content_tag(:i, '', class: 'icon-download-alt')
      concat t('events.show.btn.download_photos')
    end
  end
end