class PasswordResetsController < ApplicationController
  before_action :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def edit; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:infor] = t "infor_reset_pw"
      redirect_to root_url
    else
      flash.now[:danger] = t "email_not_found"
      render :new
    end
  end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, "#{t "empty_pw"}"
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.update_column(:reset_digest, nil)
      flash[:success] = t "pw_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def valid_user
    @user = User.activated.find_by email: params[:email] 
    return if @user&.authenticated?(:reset, params[:id])

    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?
      
    flash[:danger] = t "pw_expired"
    redirect_to new_password_reset_url
  end
end
