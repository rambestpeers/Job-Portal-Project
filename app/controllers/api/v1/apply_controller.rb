# frozen_string_literal: true

module Api
  module V1
    class ApplyController < ApiController
      # before_action :authenticate_user!
      skip_before_action :verify_authenticity_token
      def index
        @apply = Apply.where(user_id: current_user.id)
        render json: @apply
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
  end
end
