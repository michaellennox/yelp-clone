module ReviewsHelper
  def review_params
    params.require(:review).permit(:thoughts, :rating).merge(user: current_user)
  end

  def star_rating(rating)
    return rating unless rating.is_a?(Fixnum)
    "\u2605" * rating + "\u2606" * (5 - rating)
  end
end
