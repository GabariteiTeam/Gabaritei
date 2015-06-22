json.array!(@questions) do |question|
  json.extract! question, :id, :text, :type, :date, :subjects
  json.url question_url(question, format: :json)
end
