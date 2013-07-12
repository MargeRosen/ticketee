require 'spec_helper'

describe ProjectsController do
#  ActiveRecord::NotFound exception handling
it "displays an error for a missing project" do
  get :show, :id => "not-here"
  response.should redirect_to(projects_path)
  message = "The project you were looking for could not be found."
  flash[:alert].should == message
end
end
def create
  @project = Project.new(params[:project])
  if @project.save
    flash[:notice] = "Project has been created."
    redirect_to @project
  else
    flash[:alert] = "Project has not been created."
    render :action => "new"
  end
end
