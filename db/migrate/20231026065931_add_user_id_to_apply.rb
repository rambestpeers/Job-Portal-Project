# frozen_string_literal: true

class AddUserIdToApply < ActiveRecord::Migration[7.1]
  def change
    add_reference :applies, :user, foreign_key: true
  end
end
