class CreateClacbtExams < ActiveRecord::Migration[7.1]
  def up
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto') # Ensures UUID support for PostgreSQL

    create_table :clacbt_exams, id: :uuid do |t|
      t.references :clacbt_user, null: false, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.integer :duration, null: false  # Duration in minutes
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :exam_code, null: false

      t.timestamps
    end

    add_index :clacbt_exams, :exam_code, unique: true
  end

  def down
    drop_table :clacbt_exams
  end
end
