class User < ApplicationRecord
  validates :name, presence: true
  validates :role, inclusion: { in: [true, false] }
  # after_create :after_create_mail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :jobs, dependent: :destroy
  has_many :applies, dependent: :destroy
 

  def after_create_mail
    UserMailer.welcome_email(self).deliver_now
  end

  # def generate_jwt
  #   byebug
  #   payload = { user_id: id }
  #   JwtService.encode(payload)
  # end


 
end
