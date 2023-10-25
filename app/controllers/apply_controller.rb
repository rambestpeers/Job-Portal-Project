class ApplyController < ApplicationController
  before_action :authenticate_user!
    def index

    end
      
    def new
      @apply = Apply.new
    end

    def create
      @apply = Apply.new(app_params)
    end

    private

      def app_params
        params.require(:apply).permit(:name, :about_yourself, :skills, :notice_period, :cv)
      end
end
