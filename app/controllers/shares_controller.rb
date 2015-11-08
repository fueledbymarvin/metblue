class SharesController < ApplicationController
  respond_to :json

  def create
    package = Package.find(params[:id])
    if current_user && package
      current_user.facebook.put_connections("me", "links", link: "#{root_url}api/packages/#{package.id}", message: "Great deal to #{package.destination_airport}")
      render json: "Successfully posted to Facebook"
    else
      render json: "Could not find package", status: :not_found
    end
  end
end
