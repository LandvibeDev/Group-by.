json.array! @emails do |email|
  json.extract! email, :id, :subject, :content, :to, :from, :date
  json.url email_url(email, format: json)
end
