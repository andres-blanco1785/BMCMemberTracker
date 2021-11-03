# frozen_string_literal: true

json.array! @transaction_types, partial: 'transaction_types/transaction_type', as: :transaction_type
