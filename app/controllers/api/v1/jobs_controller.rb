# frozen_string_literal: true

module Api
  module V1
    class JobsController < ApiController
      before_action :set_job, only: %i[show edit update destroy]
      # before_action :authenticate_user!, except: [:index, :show]

      skip_before_action :verify_authenticity_token

      def index
        @jobs = if params.key?(:job_category)
                  Job.where(job_category: params[:job_category]).order('created_at desc')
                else
                  Job.all.order('created_at desc')
                end
        render json: @jobs, status: :ok
      end

      def show
        render json: @job, status: :ok
      end

      def new
        @job = current_user.jobs.build
      end

      def edit; end

      def create
        # if current_user.role == true
        # @job = current_user.jobs.build(job_params)
        @job = Job.create(job_params)
        @job.user_id = current_user
        return unless @job.save

        render json: @job
      end

      def update
        return unless current_user.admin == true
        return unless @job.update(job_params)

        respond_to do |format|
          format.json { render json: @job, status: :ok, location: @job }
        end
      end

      def destroy
        return unless current_user.admin == true

        @job.destroy!
        respond_to do |format|
          format.json { head :no_content }
        end
      end

      def my_jobs
        return unless current_user.role == true

        @job = Job.where(user_id: current_user.id)
        render json: @job
      end

      private

      def set_job
        @job = Job.find(params[:id])
      end

      def job_params
        params.require(:job).permit(:title, :description, :job_category, :location, :job_author, :job_company, :salary)
      end
    end
  end
end
