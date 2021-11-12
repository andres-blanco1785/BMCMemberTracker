# frozen_string_literal: true

json.extract! deposit, :id, :deposit_id, :officer_uin, :category, :amount, :notes, :date, :created_at, :updated_at
json.url deposit_url(deposit, format: :json)
