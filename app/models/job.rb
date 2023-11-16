# frozen_string_literal: true

class Job < ApplicationRecord
  validates :title, :description, :job_category, :location, :job_author, :job_company, :salary, presence: true
  belongs_to :user
  has_many :applies, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w(title)
  end
end
