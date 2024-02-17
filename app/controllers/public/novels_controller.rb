class Public::NovelsController < ApplicationController

  def new
    @novel = Novel.new
    @genres = Genre.all
  end

  def create
    @novel = Novel.new(novel_params.merge(genre_ids: params[:novel][:genre_ids]))
    # @novel = Novel.new(novel_params.merge(genre_id: params[:novel][:genre_id]))
    # @genre_names = params[:novel][:genre_id].split(',')
    # @genre_list = @genre_names.map { |genre_name| Genre.find_or_create_by(genre_name: genre_name) }
    @novel.customer_id = current_customer.id
    if @novel.save
      # @novel.genres = @genre_list
       redirect_to  public_customer_my_page_path
    else
     flash.now[:alert] = '投稿に失敗しました'
     @genres = Genre.all
     render 'public/novels/new'
    end
  end

  def index
    if current_customer
     @novels = Novel.all
    else
    redirect_to new_customer_session_path
    end
     if params[:search].present?
      novels = Novel.novels_search(params[:search])
     elsif params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      novels = @genre.novels.order(created_at: :desc)
     else
      novels = Novel.all.order(created_at: :desc)
     end
      @genre_lists = Genre.all
      @novels = Kaminari.paginate_array(novels).page(params[:page]).per(10)
  end

  def show
    @novel = Novel.find(params[:id])
    @comment = Comment.new
    @genre = Genre.find(params[:id])
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


  private

  def novel_params
    params.require(:novel).permit(:title, :review, :site_name, :genre_name, :star, :genres_id, genres_ids:[])
  end
end
