class Apply < ApplicationRecord
  validates :name, :skills, :about_yourself, :education, presence: true
  enum status: {pending: 0, accepted: 1, rejected:2}
  belongs_to :job
  belongs_to :user
  has_one_attached :resume
end
