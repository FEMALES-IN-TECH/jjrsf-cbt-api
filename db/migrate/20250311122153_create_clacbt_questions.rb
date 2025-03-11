class CreateClacbtQuestions < ActiveRecord::Migration[7.1]
  def up
    create_table :clacbt_questions, id: :uuid do |t|
      t.references :clacbt_exam, null: false, foreign_key: true, type: :uuid
      t.text :question, null: false
      t.integer :mark, null: false, default: 10

      t.timestamps
    end
  end

  def down
    drop_table :clacbt_questions
  end
end
