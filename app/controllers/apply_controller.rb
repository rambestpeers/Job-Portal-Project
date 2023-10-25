class ApplyController < ApplicationController
  before_action :authenticate_user!
    def index

    end
      
    def new
      byebug
      @apply = Apply.new
    end

    def create
      byebug
      @apply = Apply.new(app_params)

      # if @apply.save
      #   redirect_to @appl
      # end
      if @apply.save
        redirect_to @apply  # Redirect to the show page for the newly created Apply record
      else
        render 'new'  # Render the 'new' view with validation errors if save fails
      end
    end

    private

      def app_params
        params.require(:apply).permit(:name, :about_yourself, :skills, :notice_period, :cv)
      end
end
