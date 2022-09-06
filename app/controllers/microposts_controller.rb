class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: %i(destroy)

  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach params[:micropost][:image]
    if @micropost.save
      flash[:success] = t "mp_created"
      redirect_to root_url
    else
      @pagy, @feed_items = pagy current_user.feed.arrange,
                                items: Settings.digits.size_of_page
      flash.now[:danger] = t "mp_not_created"
      render "static_pages/home"
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = t "mp_deleted"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if @micropost.nil?
  end
end
