class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :job_category
      t.string :location
      t.string :job_author
      t.string :job_company
      t.integer :salary
      t.integer :user_id

      t.timestamps
    end
  end
end
