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

	def fetch_artist(name)
		artists = @client.get('/users', q: name)
		return artists.first
	end

	def fetch_tracks(id)
		tracks = @client.get("/users/#{id}/tracks")
		return tracks
	end

	def download_track(track)
		stream_url = track["stream_url"] ? track["stream_url"] : ''
		filename = track["user"]["username"] + ' - ' + track["title"]
		@downloader.download(stream_url, { file_name: filename, display_progress: true })
	end
end
