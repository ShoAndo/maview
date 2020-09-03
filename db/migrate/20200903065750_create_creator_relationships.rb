class CreateCreatorRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :creator_relationships do |t|

      t.timestamps
      t.references :creator, foreign_key: true
      t.references :follow, foreign_key: { to_table: :companies }

      t.index [:creator_id, :follow_id], unique: true
    end
  end
end
