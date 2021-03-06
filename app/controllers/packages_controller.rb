class PackagesController < ApplicationController
  respond_to :json

  def index
    user = User.find(params[:user_id])
    if user
      render json: Kaminari.paginate_array(user.search.sorted_packages)
        .page(params[:page]).per(params[:per_page])
    else
      render json: "Could not find search", status: :unprocessable_entity
    end
  end

  def show
    package = Package.find(params[:id])
    if package
      render json: package
    else
      render json: "Could not find package", status: :not_found
    end
  end

  def create
    render json: Package.create(package_params), status: :created
  end

  private

  def package_params
    params.permit(:origin_airport, :origin_region, :destination_airport, :destination_region, :hotel, :nights, :check_in, :check_out, :expedia_price, :jetblue_price, tags: [])
  end
end
