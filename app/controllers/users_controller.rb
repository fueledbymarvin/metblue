class UsersController < ApplicationController
  respond_to :json

  before_filter :set_user, only: [:show, :update]

  def show
    if @user
      respond_with @user, status: :created
    else
      respond_with nil, status: :not_found
    end
  end

  def create
    respond_with User.create(user_params)
  end

  def update
    if @user
      respond_with @user.update_attributes(user_params)
    else
      respond_with nil, status: :not_found
    end
  end

  private
  def user_params
    params.require(:user).permit(destinations: [], regions: [], tags: [], budget: [])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
