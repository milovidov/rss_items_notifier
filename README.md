Simple ruby gem for notification about new items in rss feed.

Use lib:

````Ruby
require 'rss_items_notifier'
listener = RssItemsNotifier::Listener.new rss_url: 'https://lenta.ru/rss/news',
                                          state_file: '/tmp/crc_feeds',
                                          rss_open_properties: { ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE }


loop do
  listener.obtain_new_items do |item|
    puts item
  end
  listener.save
  sleep 5
end
````
Or run command:
`rss_items_notifier -u https://lenta.ru/rss/news -s /tmp/crc_feeds`
