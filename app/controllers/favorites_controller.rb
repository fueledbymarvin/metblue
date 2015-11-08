class FavoritesController < ApplicationController
  respond_to :json

  before_filter :set_user, only: [:index, :create, :destroy]
  before_filter :set_package, only: [:create, :destroy]

  def index
    if @user
      render json: @user.favorites
    else
      render json: "Could not find user", status: :not_found
    end
  end

  def create
    if @user && @package
      @user.favorites << @package
      render json: @user.favorites
    else
      render json: "Could not find user", status: :not_found
    end
  end

  def destroy
    if @user && @package
      @user.favorites.delete(@package)
      render json: @user.favorites
    else
      render json: "Could not find user", status: :not_found
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_package
    @package = Package.find(params[:id])
  end
end
