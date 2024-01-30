class DepositsController < ApplicationController
  before_action :set_tradeline, only: [:index]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    render json: Deposit.where(tradeline_id: @tradeline)
  end

  def show
    render json: Deposit.find(params[:id])
  end

  private

  def set_tradeline
    @tradeline = Tradeline.find(params[:tradeline_id])
  end

  def not_found
    render json: 'not_found', status: :not_found
  end
end
