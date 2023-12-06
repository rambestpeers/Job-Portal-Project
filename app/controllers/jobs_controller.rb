# frozen_string_literal: true

class JobsController < ApplicationController
  before_action :set_job, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index   
    @q = Job.ransack(params[:q])
    if params.key?(:q)
      @jobs = @q.result
    else
      if params.key?(:job_category)
        @jobs =Job.where(job_category: params[:job_category]).order('created_at desc')
      else
      
        @jobs =Job.all.order('created_at desc')
        
      end
    end
  end

  def show; end

  def new
    @job = Job.new
  end

  def edit; end

  def create
    return unless current_user.role == true

    @job = current_user.jobs.build(job_params)
    # byebug
    # @job = Job.create(job_params)

    #  @job.user_id = 1
    #  @job.save
    #  render json: @job
    # byebug
    respond_to do |format|
      if @job.save
        format.html { redirect_to job_url(@job), notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    return unless current_user.admin == true

    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to job_url(@job), notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    return unless current_user.admin == true

    @job.destroy!
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my_jobs
    return unless current_user.role == true

    @job = Job.where(user_id: current_user.id)
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :job_category, :location, :job_author, :job_company, :salary)
  end
end
