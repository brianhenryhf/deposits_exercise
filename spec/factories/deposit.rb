# frozen_string_literal: true

FactoryBot.define do
  factory :deposit do
    association :tradeline
    deposit_date { Date.strptime('2023-01-01', '%Y-%m-%d') }
    amount { 22.01 }
  end
end
