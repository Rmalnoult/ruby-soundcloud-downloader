json.array!(@artists) do |artist|
  json.extract! artist, :id, :name, :photo
  json.url artist_url(artist, format: :json)
end
