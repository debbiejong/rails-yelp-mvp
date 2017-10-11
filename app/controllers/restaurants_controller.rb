class RestaurantsController < ApplicationController

  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def show
  end

  def top
    @restaurants = Restaurant.all
    highly_rated = @restaurants.select do |restaurant|
      sum = 0
      count = 0
      restaurant.reviews.each do |review|
        sum += review.rating
        count += 1
      end
      (sum.to_f / count) > 4.5
    end
    @restaurants = highly_rated
    # @restaurants = Restaurant.all
    # redirect_to restaurants_top_restaurants_path
  end


  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @restaurant.update(restaurant_params)
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone_number, :category)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
