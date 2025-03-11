class CreateClacbtCandidates < ActiveRecord::Migration[7.1]
  def up
    create_table :clacbt_candidates, id: :uuid do |t|
      t.references :clacbt_exam, null: false, foreign_key: true, type: :uuid
      t.string :email, null: false
      t.integer :score, null: true  # Score can be NULL initially

      t.timestamps
    end

    # Ensure the same email can register for multiple exams but only once per exam
    add_index :clacbt_candidates, [:clacbt_exam_id, :email], unique: true
  end

  def down
    drop_table :clacbt_candidates
  end
end
