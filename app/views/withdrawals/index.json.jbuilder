# frozen_string_literal: true

json.array! @withdrawals, partial: 'withdrawals/withdrawal', as: :withdrawal
