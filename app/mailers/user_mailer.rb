class UserMailer < ApplicationMailer
    default from: 'rapatidar@bestpeers.in'
    before_action :set_user, only: []

    def welcome_email(user)
      
      @user = user
      
      @url = "smtp://sandbox.smtp.mailtrap.io:2525"
     
      mail(to: @user.email, subject: "Account Created")
      
    end

    def accept_application(apply)
      @apply = apply
      mail(to: @apply.user.email, subject: 'Application accepted')     
    end
    
    def reject_application(apply)
      @apply = apply
      mail(to: @apply.user.email, subject: 'Application rejected')
    end

    private 

    def set_user
      
       @job = params[:id]
       
    end
end
