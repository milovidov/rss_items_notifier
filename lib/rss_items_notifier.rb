require 'open-uri'
require 'openssl'
require 'zlib'
require 'set'
require 'rss'
require 'fileutils'

module RssItemsNotifier

  class Listener
    attr_accessor :name

    def initialize(settings)
      @crc_feeds = Set.new
      @rss_url = settings[:rss_url]
      @rss_open_properties = settings[:rss_open_properties]
      @name = settings[:name] || @rss_url
      @state_file = settings[:state_file]

      load
    end

    def obtain_new_items
      new_crc_feeds = Set.new
      open(@rss_url, @rss_open_properties) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items.each do |item|
          feed_crc = Zlib::crc32(item.link).to_i
          new_crc_feeds.add feed_crc
          yield item unless @crc_feeds.include?(feed_crc)
        end
      end
      @crc_feeds = new_crc_feeds unless new_crc_feeds.empty?
    end

    def save
      if @state_file then
        File.open(@state_file, 'w+') do |f|
          f.puts(@crc_feeds.to_a)
        end
      end
    end

    protected

    def load
      if @state_file then
        FileUtils.touch @state_file
        File.open(@state_file, 'r+') do |f|
          f.each_line do |line|
            @crc_feeds.add line.to_i
          end
        end
      end
    end
  end
end

