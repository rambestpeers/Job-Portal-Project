class ApplyController < ApplicationController
  before_action :authenticate_user!
    def index
      @apply = Apply.where(user_id: current_user.id)
    end
      
    def new
      @job = Job.find(params[:job_id])
      @apply = Apply.new(job: @job)
    end

    def create
      
      @apply = Apply.new(app_params)
      @apply.user = current_user
      @apply.job = Job.find(params[:job_id])

      if @apply.save        
        # UserMailer.welcome_email(current_user).deliver_now        
        redirect_to jobs_path
      else
        render 'new'
      end
    end

    private

      def app_params
        params.require(:apply).permit(:name, :about_yourself, :skills, :notice_period, :cv, :job_id, :user_id)
      end
end
