class CreateGenresSelects < ActiveRecord::Migration[6.1]
  def change
    create_table :genres_selects do |t|
      t.integer :genre_name_id, null: false
      t.integer :novel_id, null: false
      t.timestamps
    end
  end
end
