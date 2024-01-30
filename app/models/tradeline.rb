class Tradeline < ApplicationRecord
  has_many :deposits

  def outstanding_balance
    amount - total_deposit_amounts
  end

  private

  def total_deposit_amounts
    deposits.pluck(:amount).sum
  end
end
