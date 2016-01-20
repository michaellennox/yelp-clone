module ReviewsHelper
  def review_params
    params.require(:review).permit(:thoughts, :rating).merge(user: current_user)
  end
end
