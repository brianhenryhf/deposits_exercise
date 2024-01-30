class Deposit < ApplicationRecord
  belongs_to :tradeline

  validate :cannot_exceed_tradeline_balance
  # TODO use different validator with Date::DATE_FORMATS[:db] and a test parse for more definitive check
  validates :deposit_date, format: {
    with: /\d{4}-\d{2}-\d{2}/, allow_blank: true, message: "is not in accepted date format"
  }
  validates :deposit_date, :amount, presence: true


  private

  def cannot_exceed_tradeline_balance
    if tradeline.outstanding_balance - amount < 0
      errors.add(:amount, "can't exceed tradeline balance")
    end
  end
end
