json.extract! member, :id, :uin, :name, :email, :membershipType, :expiration, :joinDate, :created_at, :updated_at
json.url member_url(member, format: :json)
