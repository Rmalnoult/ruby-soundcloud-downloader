require 'soundcloud'
require "soundcloud-downloader"
require 'awesome_print'
# soundcloud related operations
require_relative('client')
# models
require_relative('artist')
require_relative('track')
# view
require_relative('view')

CLIENT = Client.new

# controller
class Main
  def self.run
    view = View.new

	artist_name = view.ask_for_artist_name()

	artist = CLIENT.get_artist(artist_name)
	tracks = CLIENT.get_tracks(artist.id)

	view.display_tracks(artist, tracks)

	track_index = view.ask_for_track_index
	track = tracks[track_index]

	CLIENT.download_track(artist, track)
	view.display_success_message(artist, track)
  end
end

Main.run()
