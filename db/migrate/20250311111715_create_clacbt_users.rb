class CreateClacbtUsers < ActiveRecord::Migration[7.1]
  def up
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :clacbt_users, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :clacbt_users, :email, unique: true
  end

  def down
    remove_index :clacbt_users, :email
    drop_table :clacbt_users
  end
end
