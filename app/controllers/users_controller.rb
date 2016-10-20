class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
  def new
  end
end
