json.extract! offer, :id, :title, :status, :offer_type, :location, :profile_id, :created_at, :updated_at
json.url offer_url(offer, format: :json)
