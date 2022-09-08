class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend

  before_action :set_locale

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "plz_login"
    redirect_to login_url
  end

  def user_not_found
    flash[:danger] = t "not_found"
    redirect_to root_url
  end
  
  def find_user
    @user = User.find_by id: params[:id]
    return if @user&.activated?

    user_not_found
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
