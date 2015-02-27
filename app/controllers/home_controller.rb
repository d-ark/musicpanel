require 'openapi'

class HomeController < ApplicationController
  def index
    request = Openapi.new openapi_params

    page = params[:page].to_i - 1
    page = 0 if page < 0
    @playlist = request.get_tracks(10, 10*page).map do |track|
      {
        title: track['title'],
        mp3: track['music_url'],
        colors: track['colors'],
        bpm: track['bpm'],
        energy: track['energy'],
      }
    end
  end

  def openapi_params
    params.permit(:q, bpm: [:to, :from], energy: [:to, :from], colors: ALLOWED_COLORS)
  end

  ALLOWED_COLORS = {
    orange: [:to, :from],
    red:    [:to, :from],
    purple: [:to, :from],
    blue:   [:to, :from],
    green:  [:to, :from],
    white:  [:to, :from],
    grey:   [:to, :from],
    yellow: [:to, :from],
    black:  [:to, :from]
  }
end
