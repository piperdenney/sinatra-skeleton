class CreateEntries < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, { limit: 64, null: false }
      t.text :body, { null: false }
      t.belongs_to :user 

      t.timestamps
    end
  end
end
