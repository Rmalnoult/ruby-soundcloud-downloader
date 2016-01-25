class Client
	def initialize
		@client = SoundCloud.new({
			client_id: "db8f3af04d883b4290ce48092e94d52e",
			client_secret: "ea13b1094058ce81450d821558a39fc7"
		})

		@downloader = SoundCloud::Downloader::Client.new({
		  client_id: "db8f3af04d883b4290ce48092e94d52e",
		  # Le dossier où télécharger les tracks (ex: downloads)
		  path: "downloads"
		})

	end

	def get_artist(name)
		artists = @client.get('/users', q: name)
		artist_soundcloud = artists.first
		artist = Artist.new({
			id: artist_soundcloud["id"],
			name: artist_soundcloud["username"],
			url: artist_soundcloud["url"]
		})
		return artist
	end

	def get_tracks(id)
		tracks_souncloud = @client.get("/users/#{id}/tracks")
		tracks = []
		tracks_souncloud.each do |track_sc|
			track = Track.new({
				id: track_sc['id'],
				title: track_sc['title'],
				url: track_sc['stream_url'],
			})
			tracks << track
		end
		return tracks
	end

	def download_track(artist, track)
		stream_url = track.url ? track.url : ''
		filename   = artist.name + ' - ' + track.title
		@downloader.download(stream_url, { file_name: filename, display_progress: true })
	end
end
