class ProjectsController < ApplicationController
	def index
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

	def show
  	@project = Project.find(params[:id]) #find method on class Project using ActiveRecord
	end

end
