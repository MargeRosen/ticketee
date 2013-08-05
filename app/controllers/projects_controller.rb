class ProjectsController < ApplicationController

  before_filter :authorize_admin!, :except => [:index, :show]
  before_filter :authenticate_user!, :only => [:index, :show]
  before_filter :find_project, :only => [:show, :edit,
                                       :update, :destroy]

	def index
    @projects = Project.for(current_user).all
	end

	def new  #blank form
		@project = Project.new
	end

	def create  #based on user input
  	@project = Project.new(params[:project])
  	if @project.save  # returns true or false
    	flash[:notice] = "Project has been created."
    	redirect_to @project
  	else
   		flash[:notice] = "Project has NOT been created."
   		render :action => "new"
  	end
	end
#The @project variable is now setup with the before_filter
	def show
  	#@project = Project.find(params[:id]) #find method on class Project using ActiveRecord
    #@project = Project.viewable_by(current_user).find(params[:id])
    #@project = if current_user.admin?
     # Project.find(params[:id])
    #else
      #Project.viewable_by(current_user).find(params[:id])
    #end
    #@project = Project.for(current_user).find(params[:id])
    @tickets = @project.tickets
  end

  def edit
    #@project = Project.find(params[:id])
  end

  def update
    #@project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash[:alert] = "Project has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    #@project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project has been deleted."
    redirect_to projects_path
  end

  #  Moved def authorize_admin! to application_controller.rb
  #private

  #def authorize_admin!
  #  authenticate_user!
  #  unless current_user.admin?
  #    flash[:alert] = "You must be an admin to do that."
  #    redirect_to root_path
      # attr_reader :attr_namesedirect_to root_path
  #  end
  #end

  private  # so the controller doesn’t respond to this method as an action.
  def find_project
    #@project = Project.find(params[:id])
    @project = Project.for(current_user).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you were looking" +
                    " for could not be found."
    redirect_to projects_path
  end

  def authorize_admin!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to root_path
    end
  end
end
