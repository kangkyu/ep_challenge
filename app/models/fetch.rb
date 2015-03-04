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
      if event["repository"]
        self.events.create(time_created: event["created_at"], repo_name: event["repository"]["name"])
      elsif event["repo"]
        self.events.create(time_created: event["created_at"], repo_name: event["repo"]["name"])
      else
      end
    end
  end

end
