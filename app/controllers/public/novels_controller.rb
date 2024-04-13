class Public::NovelsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @novel = Novel.new
    @genres = Genre.all
  end

  def create
    @novel = Novel.new(novel_params.merge(genre_ids: params[:novel][:genre_ids]))
    @novel.customer_id = current_customer.id
    if @novel.save
       redirect_to  public_customer_my_page_path
    else
     flash.now[:alert] = '投稿に失敗しました'
     @genres = Genre.all
     render 'public/novels/new'
    end
  end

  def index
    genre_ids = (params[:genre_ids] || [""]).reject(&:blank?)
    content = params[:content]
    method = params[:method]
    sort_by = params[:sort_by]
    start_date = params[:start_date]
    end_date = params[:end_date]
    min_star = params[:min_star]
    max_star = params[:max_star]

    @novels = Novel.all

    if genre_ids.present?
      @novels = Novel.joins(:genres_selects).where(genres_selects: {genre_id: genre_ids}).distinct
    end

    if content.present?
      @novels =  Novel.search_for(@novels, content, method)
    end

    if start_date.present? && end_date.present?
      @novels = @novels.where(created_at: start_date.to_date.beginning_of_day..end_date.to_date.end_of_day)
    end

    if min_star.present? && max_star.present?
      @novels = @novels.where(star: min_star..max_star)
    end

    case sort_by
    when 'latest'
      @novels = @novels.latest
    when 'old'
      @novels = @novels.old
    when 'star_count'
      @novels = @novels.star_count
    when 'all'
      @novels = Novel.all
    else
      @novels = @novels
    end

    @novels = @novels.page(params[:page]).per(10)
  end

  def show
    @novel = Novel.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @novel = Novel.find_by(id: params[:id])

    if @novel.blank?
      redirect_to public_novels_path, notice: "小説がありません"
      return
    end

    if @novel.customer_id != current_customer.id
      redirect_to public_novels_path, notice: "他のユーザーのデータです"
      return
    end

    @genres = Genre.all

    if @novel.nil?
      @novels = Novel.all
      redirect_to public_novels_path
    end
  rescue ActiveRecord::RecordNotFound
   redirect_to root_path, notice: "小説が見つかりません"
  end

  def update
   @novel = Novel.find(params[:id])
   if @novel.update(novel_params)
   redirect_to public_my_novels_path(@novel)
   else
    render :edit
   end
  end

  def destroy
   @novel = Novel.find(params[:id])
    if @novel.customer == current_customer # ログインしている顧客がその小説の作者であるかを確認
      @novel.destroy
      flash[:notice] = '小説が削除されました'
      redirect_to request.referrer
    else
      flash[:alert] = 'この小説を削除できませんでした'
      redirect_to request.referrer
    end
  end


  private

  def novel_params
    params.require(:novel).permit(:title, :review, :site_name, :genre_name, :star, :genre_id, genre_ids:[])
  end
end
