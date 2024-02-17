class RemoveNovelsFromNovels < ActiveRecord::Migration[6.1]
  def change
    remove_column :novels, :genre_id, :integer
  end
end
