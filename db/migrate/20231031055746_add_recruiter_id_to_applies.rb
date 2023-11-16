# frozen_string_literal: true

class AddRecruiterIdToApplies < ActiveRecord::Migration[7.1]
  def change
    add_column :applies, :recuiter_id, :integer
  end
end
