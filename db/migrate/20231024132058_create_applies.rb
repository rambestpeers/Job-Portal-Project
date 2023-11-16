# frozen_string_literal: true

class CreateApplies < ActiveRecord::Migration[7.1]
  def change
    create_table :applies do |t|
      t.string :name
      t.string :skills
      t.string :about_yourself
      t.string :cv
      t.integer :notice_period
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end
