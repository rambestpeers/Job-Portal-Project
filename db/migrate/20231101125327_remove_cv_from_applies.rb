# frozen_string_literal: true

class RemoveCvFromApplies < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies, :cv
  end
end
