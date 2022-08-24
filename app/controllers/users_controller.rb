class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)

  def show  
    return if @user

    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t "welcome"
      redirect_to @user
    else
      flash[:danger] = t "failure"
      render :new
    end
  end

  def index
    @pagy, @users = pagy User.sort_list, items: Settings.digits.size_of_page
  end

  def edit; end

  def update
    if @user.update user_params 
      flash[:success] = t "updated"
      redirect_to @user
    else
      flash[:danger] = t "not_updated"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "deleted"
    else
      flash[:danger] =  t "not_deleted"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "plz_login"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless @user == current_user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
