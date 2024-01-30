class DepositsController < ApplicationController
  before_action :set_tradeline, only: [:index, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    render json: Deposit.where(tradeline_id: @tradeline)
  end

  def show
    render json: Deposit.find(params[:id])
  end

  # 2018-01-09 is AR-accepted format for dates
  def create
    deposit = @tradeline.deposits.build(deposits_params)
    unless deposit.save
      render json: {errors: [deposit.errors]}, status: :unprocessable_entity
    end
  end

  private

  def set_tradeline
    @tradeline = Tradeline.find(params[:tradeline_id])
  end

  def not_found
    head :not_found
  end

  def deposits_params
    @deposits_params ||= params.require(:deposit).permit(:deposit_date, :amount)
  end
end
