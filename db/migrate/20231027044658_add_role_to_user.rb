# frozen_string_literal: true

class AddRoleToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :boolean
  end
end
