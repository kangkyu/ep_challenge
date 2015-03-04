class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(1)
  end
end
