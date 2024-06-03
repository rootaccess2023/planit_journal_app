json.extract! entry, :id, :category, :title, :description, :start_time, :end_time, :created_at, :updated_at
json.url entry_url(entry, format: :json)
