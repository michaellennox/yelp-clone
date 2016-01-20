class RestaurantsController < ApplicationController
  include RestaurantsHelper

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.created_by?(current_user)
      @restaurant.update(restaurant_params)
    else
      flash[:notice] = 'Restaurant can only be edited by creator'
    end
    redirect_to restaurants_path
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.created_by?(current_user)
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
    else
      flash[:notice] = 'Restaurant can only be deleted by creator'
    end
    redirect_to restaurants_path
  end
end
