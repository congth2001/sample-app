class FollowersController < ApplicationController
  before_action :find_user, :logged_in_user, only: :index

  def index
    @title = t "followers"
    @pagy, @users = pagy @user.followers, items: Settings.digits.size_of_page
    render "users/show_follow"
  end
end
