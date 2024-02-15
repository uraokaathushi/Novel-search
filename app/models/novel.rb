class Novel < ApplicationRecord

    belongs_to :customer
    has_many :favorites
    has_many :comments, dependent: :destroy
    has_many :genres_select, dependent: :destroy
    has_many :genres, through: :genres_select

  #検索メソッド、タイトルと内容をあいまい検索する
 def self.genres_serach(search)
   Novel.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
 end

 def save_novels(genres)
   current_genres = self.genres.pluck(:genre_name) unless self.genres.nil?
   old_genres = current_genres - genres
   new_genres = genres - current_genres

   # Destroy
   old_genres.each do |old_name|
     self.genres.delete Genre.find_by(genre_name:old_name)
   end

   # Create
   new_genres.each do |new_name|
     novel_genre = Tag.find_or_create_by(genre_name:new_name)
     self.genres << novel_genre
   end
 end

end
