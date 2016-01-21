require 'soundcloud'
require "soundcloud-downloader"
require 'awesome_print'
require 'colorize'
# $ gem install colorize
# $ gem install awesome_print
# $ gem install soundcloud-downloader

# Ici on utilise une constante (en majuscule) car les constantes sont globales
# ce qui nous permettra d'appeler notre variable CLIENT depuis n'importe quelle méthode
CLIENT = SoundClound.new({
  client_id: "Vdb8f3af04d883b4290ce48092e94d52e",
  client_secret: "ea13b1094058ce81450d821558a39fc7"
})

downloader = SoundCloud::Downloader::Client.new({
  client_id: "Vdb8f3af04d883b4290ce48092e94d52e",
  # Le dossier où télécharger les tracks (ex: downloads)
  path: "downloads"
})

# Affiche les 10 tracks les plus en vogue
# ap CLIENT.get('/tracks', :limit => 10, :order => 'hotness')


def getArtist(name)
	artists = CLIENT.get('/users', q: name)
	return artists.first
end

def getTracks(artist_id)
	return CLIENT.get("/users/#{artist_id}/tracks")
end

puts "Entrez le nom de l'artiste"
artist_name = gets.chomp
ap 'name' + artist_name

artist = getArtist(artist_name)
ap 'artist' + artist
artist_id = artist["id"]

# renvoie un tableau de tracks sous form de hash
tracks = getTracks(artist_id)
ap 'tracks : ' + tracks
ap tracks[1] # => Un hash contenant toutes les informations sur la track
ap tracks[1]["title"] # => Nom de la deuxième track
ap tracks[1]["stream_url"] # => Lien à suivre pour écouter la deuxième track

name = ap tracks[1]["title"]
downloader.download(track_stream_url, { file_name: name, display_progress: true })



puts "unestring".orange # Affichera une string de couleur orange dans le terminal
