class CreateGenresSelects < ActiveRecord::Migration[6.1]
  def change
    create_table :genres_selects do |t|
      t.references :novel, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.timestamps
    end
  end
end

