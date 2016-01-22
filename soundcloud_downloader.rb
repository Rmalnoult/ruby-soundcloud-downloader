require 'soundcloud'
require "soundcloud-downloader"
require 'awesome_print'
require 'colorize'

# Ici on utilise une constante (en majuscule) car les constantes sont globales
# ce qui nous permettra d'appeler notre variable CLIENT depuis n'importe quelle méthode
CLIENT = SoundCloud.new({
  client_id: "db8f3af04d883b4290ce48092e94d52e",
  client_secret: "ea13b1094058ce81450d821558a39fc7"
})

downloader = SoundCloud::Downloader::Client.new({
  client_id: "db8f3af04d883b4290ce48092e94d52e",
  # Le dossier où télécharger les tracks (ex: downloads)
  path: "downloads"
})

def getArtist(name)
	artists = CLIENT.get('/users', q: name)
	return artists.first
end

def getTracks(artist_id)
	return CLIENT.get("/users/#{artist_id}/tracks")
end

def display_tracks(tracks)
	i = 0
	tracks.each do |track|
		i = i + 1
		puts i.to_s + ' | ' + track['title']
	end
end

puts "Entrez le nom de l'artiste"
artist_name = gets.chomp

artist = getArtist(artist_name)

tracks = getTracks(artist["id"])

display_tracks(tracks)

puts "Entrez le numero de la track à télécharger"
track_number = gets.chomp.to_i - 1

filename = tracks[track_number]["user"]["username"] + ' - ' + tracks[track_number]["title"]
stream_url = tracks[track_number]["stream_url"]
downloader.download(stream_url, { file_name: filename, display_progress: true })

puts 'All good ! The song ' + tracks[track_number]["title"] + ' by artist ' + tracks[track_number]["user"]["username"] + ' was just downloaded'
