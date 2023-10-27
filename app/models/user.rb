class User < ApplicationRecord
  validates :name, presence: true
  validates :role, inclusion: { in: [true, false] }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :jobs     
  has_many :applies  
end
