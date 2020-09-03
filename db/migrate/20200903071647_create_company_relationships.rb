class CreateCompanyRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :company_relationships do |t|

      t.timestamps
      t.references :company, foreign_key: true
      t.references :follow, foreign_key: { to_table: :creators }
      t.index [:company_id, :follow_id], unique: true
    end
  end
end
