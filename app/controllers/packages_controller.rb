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
end
