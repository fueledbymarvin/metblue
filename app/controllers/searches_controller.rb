class SearchesController < ApplicationController
  respond_to :json

  before_filter :set_search, only: [:show, :update]

  def show
    if @search
      render json: @search, status: :created
    else
      render json: "Could not find search", status: :not_found
    end
  end

  def update
    if @search
      render json: @search.update_attributes(search_params)
    else
      render json: "Could not find search", status: :not_found
    end
  end

  private

  def search_params
    params.require(:search).permit(:budget, :start_date, :end_date, tags: [], origin_airports: [], origin_regions: [], destination_airports: [], destination_regions: [])
  end

  def set_search
    @search = User.find(params[:user_id]).search
  end
end
