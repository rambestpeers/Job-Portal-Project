# frozen_string_literal: true

class RemoveColumnFromApplies < ActiveRecord::Migration[7.1]
  def change
    remove_column :applies, :recuiter_id
  end
end
