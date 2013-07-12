class ProjectsController < ApplicationController
	def index
    @projects = Project.all
	end

	def new  #blank form
		logger.info "message for log file:  processed new method in ProjectsController"
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
#This needs to be DRYed
	def show
  	@project = Project.find(params[:id]) #find method on class Project using ActiveRecord
	end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash[:alert] = "Project has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project has been deleted."
    redirect_to projects_path
  end
end
