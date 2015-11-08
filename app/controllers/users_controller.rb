class UsersController < ApplicationController
  respond_to :json

  before_filter :set_user, only: [:show]

  def show
    if @user
      respond_with @user, status: :created
    else
      respond_with nil, status: :not_found
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
