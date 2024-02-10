class CreateNovels < ActiveRecord::Migration[6.1]
  def change
    create_table :novels do |t|
      t.integer :customer_id, null: false
      t.string :title
      t.string :site_name
      t.text :review
      t.timestamps
    end
  end
end
