require 'rails_helper'

describe ReviewsController, type: :controller do
  it { is_expected.to use_before_action :authenticate_user! }
end
