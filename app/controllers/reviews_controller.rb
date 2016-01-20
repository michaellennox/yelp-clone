class ReviewsController < ApplicationController
  include ReviewsHelper

  before_action :authenticate_user!

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.has_reviewed?(@restaurant)
      flash[:notice] = 'You cannot review the same restaurant more than once'
    else
      @restaurant.reviews.create(review_params)
    end
    redirect_to restaurants_path
  end
end
