class AddTradelinesRefToDeposits < ActiveRecord::Migration[7.1]
  def change
    add_reference :deposits, :tradeline, null: false, foreign_key: true
  end
end
