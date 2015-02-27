require 'open-uri'
require 'zlib'
require 'yajl'

class Fetch < ActiveRecord::Base
  
  validates :get_info, presence: true
  has_many :events

  def events_json
    gz = open(self.get_info)
    Zlib::GzipReader.new(gz).read
  end

  def save_events_hash
    parser = Yajl::Parser.new
    parser.parse(events_json) do |event|
      self.events.create(hsh: event)
    end
  end

end
