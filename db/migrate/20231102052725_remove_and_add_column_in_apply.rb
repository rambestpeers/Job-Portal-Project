# frozen_string_literal: true

class RemoveAndAddColumnInApply < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies, :notice_period
    add_column :applies, :education, :string
  end
end
