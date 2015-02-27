class Event < ActiveRecord::Base
  serialize :hsh
  belongs_to :fetch
end
