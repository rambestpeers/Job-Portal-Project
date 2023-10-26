class UserMailer < ApplicationMailer
    default from: 'your_email@example.com'

    def welcome_email(user)
        @user = user
        @url = "smtp://sandbox.smtp.mailtrap.io:2525"
        mail(to: @user.email, subject: "Appication Applied Successfully")

    end


end
