class ApiController < ApplicationController
  
  before_action :authenticate_request, except: [:create, :login]
  def current_user
    byebug
    # return @current_user if defined?(@current_user)
    token = request.headers['Authorization']&.split(' ')&.last
    
    return unless token
    
    decoded = AuthenticationTokenService.decode_token(token)
    
    @current_user = User.find(decoded['user_id'])
    
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    nil
  end


  
  

  def authenticate_request
    render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user
  end

  # @current_user ||= User.find(@token.id) if @token.present?
  # end
end