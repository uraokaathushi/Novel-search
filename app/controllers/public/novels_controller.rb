class Public::NovelsController < ApplicationController

  def new
    @novel = Novel.new
  end

  def create
    @novel = Novel.new(novel_params)
    # genre_list = params[:novel][:genre_name].split(nil)  #adminで使用する
    @novel.customer_id = current_customer.id
    @novel.save
    @novel.save_genre(genre_list)  #adminで使用する
    redirect_to  public_customer_my_page_path
  end

  def index
    if current_customer
     @novels = Novel.all
    else
    redirect_to new_customer_session_path
    end
    
    if params[:search].present?
     novels = Novel.novels_serach(params[:search])
    elsif params[:genre_id].present?
     @genre = Genre.find(params[:genre_id])
     novels = @genre.novels.order(created_at: :desc)
    else
     novels = Novel.all.order(created_at: :desc)
    end
     @genre_lists = Genre.all
     @novels = Kaminari.paginate_array(novels).page(params[:page]).per(10)
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


  private

  def novel_params
    params.require(:novel).permit(:title, :review, :site_name, :genre_name, :star)
  end

end
