class ScDownloader
	def initialize
		@client = SoundCloud.new({
			client_id: Rails.application.secrets.soundcloud_client_id,
			client_secret: Rails.application.secrets.soundcloud_client_secret
		})
	end

	def get_artists(name)
		artists = @client.get('/users', q: name)
		my_artists = []

		artists.each do |artist|
			artist_from_db = Artist.where(soundcloud_id: artist['id'])
			if artist_from_db.any?
				my_artist = artist_from_db.first
			else
				my_artist = Artist.create({
					name: artist['username'],
					soundcloud_id: artist['id'],
					avatar_url: artist['avatar_url'],
					permalink_url: artist['permalink_url'],
					track_count: artist['track_count'],
				})
			end

			my_artists << my_artist
		end

		return my_artists
	end

	def get_tracks(artist)
		my_tracks = Track.where(artist_id: artist.id);

		tracks_souncloud = @client.get("/users/#{artist.soundcloud_id}/tracks")
		my_tracks_titles = Track.where(artist_id: artist.id).pluck('title')
		tracks_souncloud.each do |track_sc|
			if not my_tracks_titles.include? track_sc['title']
				track = artist.tracks.create({
					title: track_sc['title'],
					duration: track_sc['duration'],
					stream_url: track_sc['stream_url'],
					artwork_url: track_sc['artwork_url'],
				})
				my_tracks << track
			end
		end
		return my_tracks
	end

end
