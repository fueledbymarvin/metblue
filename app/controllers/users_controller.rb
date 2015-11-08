class UsersController < ApplicationController
  respond_to :json

  before_filter :set_user, only: [:show]

  def show
    if @user
      render json: @user, status: :created
    else
      render json: "Could not find user", status: :not_found
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
