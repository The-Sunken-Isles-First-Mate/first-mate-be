class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :username
      t.string :token

      t.timestamps
    end

    add_index :users, :uid, unique: true
  end
end
