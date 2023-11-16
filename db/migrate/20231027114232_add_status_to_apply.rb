# frozen_string_literal: true

class AddStatusToApply < ActiveRecord::Migration[7.1]
  def change
    add_column :applies, :status, :integer, default: 0
  end
end
