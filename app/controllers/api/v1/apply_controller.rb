class Api::V1::ApplyController < ApiController
    # before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    def index
        @apply = Apply.where(user_id: current_user.id)
        render json: @apply
    end
      
    def new
      byebug
      @job = Job.find(params[:job_id])
      @apply = Apply.new(job: @job)
    end
  
    def create
      byebug
      @apply = Apply.new(app_params)
      @apply.user = current_user
      @apply.job = Job.find(params[:job_id])
      byebug
      if @apply.save              
        render json: @apply
      else
        render 'new'
      end
     
      
    end
  
    def accept
      @apply = Apply.find(params[:id])
      @apply.accepted!
      # UserMailer.accept_application(@apply).deliver_now 
      redirect_to my_jobs_jobs_path, notice: 'Job request accepted.'
    end
  
    def reject
      @apply = Apply.find(params[:id])
      @apply.rejected!
      # UserMailer.reject_application(@apply).deliver_now 
      redirect_to my_jobs_jobs_path, notice: 'Job request rejected.'
    end
  
    private
  
    def app_params
      params.require(:apply).permit(:name, :about_yourself, :skills, :education, :job_id, :user_id)
    end
end
