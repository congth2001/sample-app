class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params.dig(:session, :email)&.downcase

    return handle_login if @user&.authenticate(params.dig(:session, :password))

    flash.now[:danger] = t "invalid"
    render :new
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def handle_login
    if @user.activated?
      log_in @user
      params.dig(:session, :remember_me) == "1" ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      flash[:warning] = t "check_atv"
      redirect_to root_url
    end
  end
end
