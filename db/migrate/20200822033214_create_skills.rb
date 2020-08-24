class CreateSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :skills do |t|

      t.timestamps
      t.string :skill_name
      t.integer :level_id
      t.integer :year
      t.references :creator, foreign_key: true
    end
  end
end
