json.array!(@subjects) do |subject|
  json.extract! subject, :id, :name, :professor_id, :department_id, :descricao
  json.url subject_url(subject, format: :json)
end
