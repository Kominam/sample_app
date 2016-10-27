class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = t ".not_activate"
        message += t ".mail_check"
        flash[:warning] = message
        redirect_to root_path
      end
    else
      flash.now[:danger] = t ".invalid_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  def current_user
    if @current_user.nil?
      @current_user ||= User.find_by id: session[:user_id]
    end
      @current_user
  end
end
