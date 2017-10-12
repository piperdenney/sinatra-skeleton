class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :hashed_password
      t.string :user_name, null: false
      t.string :email, null: false, unique: true

      t.timestamps
    end
  end
end
