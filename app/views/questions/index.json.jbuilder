json.array!(@questions) do |question|
  json.extract! question, :id, :question, :type, :year, :area
  json.url question_url(question, format: :json)
end
