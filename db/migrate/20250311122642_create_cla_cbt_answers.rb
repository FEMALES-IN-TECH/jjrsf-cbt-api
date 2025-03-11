class CreateClaCbtAnswers < ActiveRecord::Migration[7.1]
  def up
    create_table :cla_cbt_answers, id: :uuid do |t|
      t.references :cla_cbt_question, null: false, foreign_key: true, type: :uuid
      t.string :option, null: false, limit: 1  # A, B, C, D
      t.text :answer_text, null: false
      t.boolean :correct, default: false, null: false

      t.timestamps
    end
  end

  def down
    drop_table :cla_cbt_answers
  end
end
