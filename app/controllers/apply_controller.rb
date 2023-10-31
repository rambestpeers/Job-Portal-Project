class ApplyController < ApplicationController
  before_action :authenticate_user!
  # before_action :find_apply, only: [:accept, :reject, :show, :destroy]
  def index
    if current_user.role == true
      @applies = Apply.where(job_id: params[:job_id])
    else
      @apply = Apply.where(user_id: current_user.id)
    end
  end
    
  def new
    @job = Job.find(params[:job_id])
    @apply = Apply.new(job: @job)
  end

  def create
    @apply = Apply.new(app_params)
    # @apply.recuiter_id = @job.user_id
    @apply.user = current_user
    
    @apply.job = Job.find(params[:job_id])
    
    

    

    if @apply.save        
      # UserMailer.welcome_email(current_user).deliver_now        
      redirect_to jobs_path
    else
      render 'new'
    end
  end

  def show
   
    
    
   
  end

  def accept
    @apply = Apply.find(params[:id])
    @apply.accepted!
    redirect_to, notice: 'Job request accepted.'

  end

  def reject
    
    @apply = Apply.find(params[:id])
    @apply.rejected!
    redirect_to, notice: 'Job request accepted.'

  end

  private

  # def find_apply
  #   @apply = Apply.find(params[:id])
  # end

  def app_params
    params.require(:apply).permit(:name, :about_yourself, :skills, :notice_period, :cv, :job_id, :user_id)
  end
end
