class AddStarToNovels < ActiveRecord::Migration[6.1]
  def change
    add_column :novels, :star, :string
  end
end
