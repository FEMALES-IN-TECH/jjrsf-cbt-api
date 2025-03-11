class CreateClaCbtQuestions < ActiveRecord::Migration[7.1]
  def up
    create_table :cla_cbt_questions, id: :uuid do |t|
      t.references :cla_cbt_exam, null: false, foreign_key: true, type: :uuid
      t.text :question, null: false
      t.integer :mark, null: false, default: 10

      t.timestamps
    end
  end

  def down
    drop_table :cla_cbt_questions
  end
end
