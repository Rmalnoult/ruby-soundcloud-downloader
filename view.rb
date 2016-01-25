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
		puts "All tracks by #{artist.name}"
		tracks.each_with_index do |track, i|
			puts i.to_s + ' | ' + track.title
		end
	end

	def ask_for_track_index
		puts "Entrez le numero de la track à télécharger"
		print '> '
		track_index = gets.chomp.to_i
		return track_index
	end

	def display_success_message(artist, track)
		puts '\n'
		puts 'All good ! The song ' + track.title + ' by artist ' + artist.name + ' was just downloaded'
	end

end
