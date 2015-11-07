class SearchesController < ApplicationController
  respond_to :json

  before_filter :set_search, only: [:show, :update]

  def show
    if @search
      respond_with @search, status: :created
    else
      respond_with nil, status: :not_found
    end
  end

  def create
    respond_with Search.create(search_params)
  end

  def update
    if @search
      respond_with @search.update_attributes(search_params)
    else
      respond_with "Could not find search", status: :not_found
    end
  end

  private

  def search_params
    params.require(:search).permit(:budget, :start_date, :end_date, tags: [], origin_airports: [], origin_regions: [], destination_airports: [], destination_regions: [])
  end

  def set_search
    @search = Search.find(params[:id])
  end
end
