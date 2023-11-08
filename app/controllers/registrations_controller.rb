class RegistrationsController < Devise::RegistrationsController
  
  # protect_from_forgery with: :null_session

  # skip_before_action :verify_authenticity_token
  private

  def sign_up_params
    params.require(:user).permit( :name, 
                                  :role,
                                  :email, 
                                  :password, 
                                  :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit( :name,
                                  :email, 
                                  :password, 
                                  :password_confirmation, 
                                  :current_password)
  end
end
