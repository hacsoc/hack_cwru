json.array!(@announcements) do |announcement|
  json.extract! announcement, :id
  json.url announcement_url(announcement, format: :json)
end
