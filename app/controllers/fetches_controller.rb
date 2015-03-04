require 'open-uri'
require 'zlib'
require 'yajl'

class FetchesController < ApplicationController

  def new
    @fetch = Fetch.new
    # @fetches = Fetch.all
  end

  def create
    @fetch = Fetch.new(fetch_params)

    if @fetch.save
      @fetch.save_events
      redirect_to fetch_path(@fetch)
    else
      render :new
    end
  end

  def show
    @fetch = Fetch.find(params[:id])
  end

  def index
    @fetches = Fetch.all
  end

  private

  def fetch_params
    params.require(:fetch).permit(:get_info, :starting_at, :ending_at)
  end

end
