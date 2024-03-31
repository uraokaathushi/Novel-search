class Novel < ApplicationRecord
validates :genres, presence:true
validates :title,presence:true

    belongs_to :customer
    has_many :favorites
    has_many :comments, dependent: :destroy
    has_many :genres_selects, dependent: :destroy
    has_many :genres, through: :genres_selects





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

 def self.search_for(data, content, method)
    if method == 'perfect'
      data.where('title = ? OR review = ?', content, content)
    elsif method == 'forward'
      data.where('title LIKE ? OR review LIKE ?', content + '%', content + '%')
    elsif method == 'backward'
      data.where('title LIKE ? OR review LIKE ?', '%' + content, '%' + content)
    else
      data.where('title LIKE ? OR review LIKE ?', '%' + content + '%', '%' + content + '%')
    end
 end

 scope :latest, -> {order(created_at: :desc)}
 scope :old, -> {order(created_at: :asc)}
 scope :star_count, -> {order(star: :desc)}

end
