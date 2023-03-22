json.extract! applicant, :id, :first_name, :last_name, :email, :phone, :stage, :status, :offer_id, :created_at, :updated_at
json.url applicant_url(applicant, format: :json)
