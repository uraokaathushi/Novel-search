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
   if params[:genre_ids]
      if params[:genre_ids].present?
          @genres = Genre.where(id: params[:genre_ids].compact_blank)
          @novels = Kaminari.paginate_array( Novel.joins(:genres_selects).where(genres_selects: {genre_id: params[:genre_ids].compact_blank }).order(created_at: :desc).uniq).page(params[:page]).per(10)
      else
          @novels = Novel.all.order(created_at: :desc).page(params[:page]).per(10)
      end
   elsif params[:method]
          @content = params[:a]
          @method = params[:method]
          @novels = Novel.search_for(@content, @method).page(params[:page]).per(10)
   elsif params[:latest]
          @novels = Novel.latest
   elsif params[:old]
          @novels = Novel.old
   elsif params[:star_count]
          @novels = Novel.star_count
   else
       @novels = Novel.all.order(created_at: :desc).page(params[:page]).per(10)
   end
  end

  def show
    @novel = Novel.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @novel = Novel.find_by(id: params[:id])
    if @novel.nil?
      @novels = Novel.all
      redirect_to public_novels_path
    end
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
    params.require(:novel).permit(:title, :review, :site_name, :genre_name, :star, :genres_id, genres_ids:[])
  end
end
