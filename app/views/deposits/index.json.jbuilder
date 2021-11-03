# frozen_string_literal: true

json.array! @deposits, partial: 'deposits/deposit', as: :deposit
