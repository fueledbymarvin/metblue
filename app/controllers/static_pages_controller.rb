class StaticPagesController < ApplicationController
  before_filter :authenticate, except: [:index]

  def index
  end

  def flights
  end

  def favorites
  end
end
