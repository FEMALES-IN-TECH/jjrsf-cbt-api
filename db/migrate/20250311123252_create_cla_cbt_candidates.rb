class CreateClaCbtCandidates < ActiveRecord::Migration[7.1]
  def up
    create_table :cla_cbt_candidates, id: :uuid do |t|
      t.references :cla_cbt_exam, null: false, foreign_key: true, type: :uuid
      t.string :email, null: false, index: { unique: true }
      t.integer :score, null: true  # Score can be NULL initially

      t.timestamps
    end
  end

  def down
    drop_table :cla_cbt_candidates
  end
end
