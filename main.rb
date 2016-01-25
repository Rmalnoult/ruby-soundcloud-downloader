require 'soundcloud'
require "soundcloud-downloader"
require 'awesome_print'
require 'colorize'
require_relative('artist')
require_relative('client')
require_relative('track')
require_relative('view')

CLIENT = Client.new

class Main
  def self.run
    view = View.new
	artist_name = view.ask_for_artist_name()
	artist = CLIENT.fetch_artist(artist_name)

	tracks = CLIENT.fetch_tracks(artist["id"])
	view.display_tracks(artist, tracks)
	track_index = view.ask_for_track_index
	track = tracks[track_index]
	CLIENT.download_track(track)
	view.display_success_message(track)

  end

end

Main.run()
