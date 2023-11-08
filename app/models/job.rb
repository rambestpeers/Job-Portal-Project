class Job < ApplicationRecord
  # validates :title, :description, :job_category, :location, :job_author, :job_company, :salary, presence: true
  belongs_to :user
  has_many :applies, dependent: :destroy
end
