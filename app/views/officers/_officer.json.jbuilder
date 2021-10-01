json.extract! officer, :id, :officerUIN, :name, :email, :amountOwed, :created_at, :updated_at
json.url officer_url(officer, format: :json)
