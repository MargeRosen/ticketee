require 'spec_helper'

describe ProjectsController do
# Admin-only for Projects actions (new, create, edit & update)
  let(:user) { Factory(:confirmed_user) }
  let(:project) { Factory(:project) }

  context "standard users" do
    before do
      sign_in(:user, user)
    end

    { :new => :get,
      :create => :post,
      :edit => :get,
      :update => :put,
      :destroy => :delete }.each do |action, method|
        it "cannot access the #{action} action" do
          sign_in(:user, user)
          send(method, action, :id => project.id)
          response.should redirect_to(root_path)
          flash[:alert].should eql("You must be an admin to do that.")
        end
      end

    it "cannot access the show action without permission" do
      sign_in(:user, user)
      get :show, :id => "not-here"
      response.should redirect_to(projects_path)
      flash[:alert].should eql("The project you were looking for could not be found.")
    end
  end

#  ActiveRecord::NotFound exception handling
  it "displays an error for a missing project" do
    sign_in(:user, user)
    get :show, :id => "not-here"
    response.should redirect_to(projects_path)
    message = "The project you were looking for could not be found."
    flash[:alert].should == message
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
end
