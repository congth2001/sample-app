class FollowingsController < ApplicationController
  before_action :find_user, :logged_in_user, only: :index

  def index
    @title = t "following"
    @pagy, @users = pagy @user.following, items: Settings.digits.size_of_page
    render "users/show_follow"
  end
end
