class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    debugger
  end

  def new
  end
end
