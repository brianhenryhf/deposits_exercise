class TradelinesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    render json: Tradeline.all
  end

  def show
    @tradeline = Tradeline.find(params[:id])
    render :show
  end

  private

  def not_found
    head :not_found
  end
end
