class Api::V1::SessionsController < ApiController
  # protect_from_forgery with: :null_session

  skip_before_action :verify_authenticity_token
  
  def create
    @user = User.new(sign_up_params)
    if @user.save
      token = AuthenticationTokenService.encode_token(@user.id)
      render json: { token: token }
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = AuthenticationTokenService.authenticate(params[:email], params[:password])
    if user
      token = AuthenticationTokenService.encode_token(user.id)
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def sign_up_params
    params.require(:user).permit( :name, 
                                  :role,
                                  :email, 
                                  :password, 
                                  :password_confirmation)
  end

end
  