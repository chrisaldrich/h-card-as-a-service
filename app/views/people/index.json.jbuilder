json.array!(@people) do |person|
  json.extract! person, :id, :name, :urls, :timezone, :birthday, :chat_usernames, :photo, :additional_info
  json.url person_url(person, format: :json)
end
