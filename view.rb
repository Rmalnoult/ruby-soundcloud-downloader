class View

	def initialize
		puts "---------- Souncloud Downloader ----------"
	end

	def ask_for_artist_name
		puts "Entrez le nom de l'artiste"
		print '> '
		artist_name = gets.chomp
		return artist_name
	end

	def display_tracks(artist, tracks)
		tracks.each.with_index do |track, i|
			puts i.to_s + ' | ' + track['title']
		end
	end

	def ask_for_track_index
		puts "Entrez le numero de la track à télécharger"
		print '> '
		track_index = gets.chomp.to_i
		return track_index
	end

	def display_success_message(track)
		puts 'All good ! The song ' + track["title"] + ' by artist ' + track["user"]["username"] + ' was just downloaded'
	end

  # ...
end
