require_relative 'lib/rss_items_notifier/version'

Gem::Specification.new do |spec|
  spec.name        = 'rss_items_notifier'
  spec.version     = RssItemsNotifier::VERSION
  spec.date        = '2018-03-21'
  spec.summary     = 'Simple ruby gem for notification about new items in rss feed'
  spec.description = 'Create RssNotifier::Listener for your targets or use rss_items_notifier application!'
  spec.authors     = ['Mikhail Milovidov']
  spec.email       = 'mikhailmilovidov@gmail.com'
  spec.files       = ['lib/rss_items_notifier.rb']
  spec.homepage    = 'https://github.com/milovidov/rss_items_notifier'
  spec.license     = 'MIT'
  spec.executables << 'rss_items_notifier'
end