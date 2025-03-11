class DropClacbtUsersAndExams < ActiveRecord::Migration[7.1]
  def change
    drop_table :cla_cbt_questions
    drop_table :cla_cbt_exams
    drop_table :cla_cbt_answers
    drop_table :cla_cbt_candidates
  end
end
