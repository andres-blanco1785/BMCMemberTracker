json.extract! member, :id, :member_uin, :name, :email, :membershipType, :expiration, :joinDate, :created_at, :updated_at
json.url member_url(member, format: :json)
