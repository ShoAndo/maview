class CreateCareers < ActiveRecord::Migration[6.0]
  def change
    create_table :careers do |t|

      t.timestamps
      t.integer :job_category_id
      t.integer :year
      t.references :creator, foreign_key: true
    end
  end
end
