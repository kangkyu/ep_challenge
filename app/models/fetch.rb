require 'open-uri'
require 'zlib'
require 'yajl'

class Fetch < ActiveRecord::Base
  
  # validates :get_info, presence: true
  has_many :events

  # def events_json
  #   gz = open(self.get_info)
  #   Zlib::GzipReader.new(gz).read
  # end

  # def save_events_hash
  #   parser = Yajl::Parser.new
  #   parser.parse(events_json) do |event|
  #     if event["repository"]
  #       self.events.create(time_created: event["created_at"], repo_name: event["repository"]["name"])
  #     elsif event["repo"]
  #       self.events.create(time_created: event["created_at"], repo_name: event["repo"]["name"])
  #     else
  #     end
  #   end
  # end

  def save_events
    self.files_to_fetch.each do |file_name|
      gz = open(file_name)
      events_json = Zlib::GzipReader.new(gz).read
      Yajl::Parser.parse(events_json) do |event|
        if event["repository"]
          self.events.create(time_created: event["created_at"], repo_name: event["repository"]["name"])
        elsif event["repo"]
          self.events.create(time_created: event["created_at"], repo_name: event["repo"]["name"])
        else
        end
      end
    end
  end

  def files_to_fetch
    starting_hour = self.starting_at.beginning_of_hour
    ending_hour = self.ending_at.beginning_of_hour
    names_array = []
    while ending_hour >= starting_hour do
      names_array << file_name_by_hour(starting_hour)
      starting_hour += 1.hour
    end
    names_array
  end

  def file_name_by_hour(file_hour)
    "http://data.githubarchive.org/" + file_hour.to_s[0..9] + "-" + file_hour.to_a[2].to_s + ".json.gz"
  end
end
