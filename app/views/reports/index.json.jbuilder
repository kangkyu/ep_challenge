json.array!(@reports) do |report|
  json.extract! report, :id, :starting_at, :ending_at
  json.url report_url(report, format: :json)
end
