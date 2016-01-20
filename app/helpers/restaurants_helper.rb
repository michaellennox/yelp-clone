module RestaurantsHelper
  def restaurant_params
    params.require(:restaurant).permit(:name).merge(user: current_user)
  end
end
