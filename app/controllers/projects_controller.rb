class ProjectsController < ApplicationController
  before_action :set_project, :set_user, only: [ :show, :update_status, :add_comment, :history ]

  def index
    @projects = Project.all
  end

  def show
    @comments = @project.project_histories.where(change_type: "comment")
  end

  def update_status
    ActiveRecord::Base.transaction do
      if @project.update(status: params[:status])
        @project.project_histories.create!(user: @current_user, content: "Status changed to #{params[:status]}", change_type: "status_change")
        redirect_to project_path(@project), notice: "Project status updated."
      else
        redirect_to project_path(@project), alert: "Failed to update status."
      end
    rescue ActiveRecord::RecordInvalid => e
      redirect_to project_path(@project), alert: "Error: #{e.message}"
    end
  end

  def add_comment
    if @project.project_histories.create!(user: @current_user, content: params[:comment], change_type: "comment")
      redirect_to project_path(@project), notice: "Comment added."
    else
      redirect_to project_path(@project), alert: "Failed to add comment."
    end
  end

  def history
    render json: @project.project_histories.order(created_at: :desc)
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_user
    # This is a placeholder for current_user, which would be set by your authentication system.
    @current_user ||= User.find(1)
  end
end
