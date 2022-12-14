class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    user_not_found unless @user

    current_user.follow @user
    
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id])&.followed
    user_not_found unless @user
    
    current_user.unfollow @user
    
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
