json.array!(@tracks) do |track|
  json.extract! track, :id, :title, :url
  json.url track_url(track, format: :json)
end
