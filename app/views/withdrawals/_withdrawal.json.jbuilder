json.extract! withdrawal, :id, :withdraw_id, :officer_uin, :transaction_id, :amount, :title, :description, :date, :created_at, :updated_at
json.url withdrawal_url(withdrawal, format: :json)
