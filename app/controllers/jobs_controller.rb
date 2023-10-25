class JobsController < ApplicationController
  before_action :set_job, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /jobs or /jobs.json
  def index
    if(params.has_key?(:job_category))
      @jobs = Job.where(job_category: params[:job_category]).order("created_at desc")
    else
      @jobs = Job.all.order("created_at desc")
    end
    
  end

  # GET /jobs/1 or /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    
      @job = current_user.jobs.build
    
    
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs or /jobs.json
  def create
    if current_user.admin == true

      @job = current_user.jobs.build(job_params)

        respond_to do |format|
        if @job.save
          format.html { redirect_to job_url(@job), notice: "Job was successfully created." }
          format.json { render :show, status: :created, location: @job }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @job.errors, status: :unprocessable_entity }
        end
       end

    
    end
  end

  # PATCH/PUT /jobs/1 or /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to job_url(@job), notice: "Job was successfully updated." }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1 or /jobs/1.json
  def destroy
    @job.destroy!

    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def apply

    @apply = Apply.create(app_params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:title, :description, :job_category, :location, :job_author, :job_company, :salary)
    end

    def app_params
      params.require(:apply).permit(:name, :about_yourself, :skills, :notice_period, :cv)
    end
end
