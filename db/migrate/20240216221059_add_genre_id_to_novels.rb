class AddGenreIdToNovels < ActiveRecord::Migration[6.1]
  def change
    add_column :novels, :genre_id, :integer
  end
end
