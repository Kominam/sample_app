class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.all
    @users = User.paginate page: params[:page]
  end

  def show
    if @user.nil?
      render file: "public/404.html", status: 404, layout: false
    else
      @microposts = @user.microposts.paginate page: params[:page]
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".mail_activate_msg"
      redirect_to root_path
    else
      flash.now[:danger] = t ".signup_fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t ".delete"
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit :name, :email, :password,
                                   :password_confirmation
    end

  def correct_user
    redirect_to root_path unless current_user? @user
  end

  # Confirms an admin user.
  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t ".user_not_found"
      redirect_to users_path
    end
  end
end
