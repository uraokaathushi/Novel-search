class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
     t.integer :customer_id, null: false
     t.integer :novel_id, null: false
     t.text :comment
      t.timestamps
    end
  end
end
