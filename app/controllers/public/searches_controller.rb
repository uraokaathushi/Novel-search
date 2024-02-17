class Public::SearchesController < ApplicationController
  
  def search
  #タグ検索
  @genre_ids = params[:genre_ids]&.select(&:present?)
  if @genre_ids.present?
    @genre_word = "ジャンル: "
    @genre_ids.each do |id|
      @genre_word = @genre_word + ' ' + Genre.find(id).genre_name if id != ""
    end
    @novels = @novels.joins(:novel_genres).where(novel_genres: {genre_id: @genre_ids}).group("novels.id").having("count(*) = #{@genre_ids.length}")
  end
  
  # 検索結果件数
  @novels_count = @novels
  
end
