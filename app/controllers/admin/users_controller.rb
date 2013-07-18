#class Admin::UsersController < ApplicationController
#
#  authorize_admin filter will run before all actions
#  inside this controller.
class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all(:order => "email")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user], :as => :admin)
    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been created."
      render :action => "new"
    end
  end
end
