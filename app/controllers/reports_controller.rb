# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :ensure_correct_user, only: %i[edit update destroy]

  def index
    @reports = Report.all
  end

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new
  end

  def edit
    @report = Report.find(params[:id])
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to @report
    else
      render new
    end
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      redirect_to @report
    else
      render edit
    end
  end

  def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to reports_path
  end

  def ensure_correct_user
    report = Report.find(params[:id])
    if current_user != report.user
      redirect_to reports_path
    end
  end

  private

  def report_params
    params.require(:report).permit(:title, :body)
  end
end
