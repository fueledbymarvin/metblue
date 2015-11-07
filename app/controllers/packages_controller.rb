class PackagesController < ApplicationController
  respond_to :json

  def index
    if params[:search_id]
      search = Search.find(params[:search_id])
      if search
        respond_with Kaminari.paginate_array(search.sorted_packages).page(params[:page]).per(params[:per_page])
      else
        respond_with "Could not find search", status: :unprocessable_entity
      end
    else
      respond_with "No search id provided", status: :unprocessable_entity
    end
  end

  def create
    respond_with Package.create(package_params), status: :created
  end

  private

  def package_params
    params.permit(:origin_airport, :origin_region, :destination_airport, :destination_region, :hotel, :nights, :check_in, :check_out, :expedia_price, :jetblue_price, tags: [])
  end
end
