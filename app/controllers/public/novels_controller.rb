class Public::NovelsController < ApplicationController

  def new
    @novel = Novel.new
  end

  def create
    @novel = Novel.new(novel_params)
    @novel.customer_id = current_customer.id
    @novel.save
    redirect_to  public_customer_my_page_path
  end

  def index
    if current_customer
     @novels = Novel.all
    else
    redirect_to new_customer_session_path
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
    params.require(:novel).permit(:title, :review, :site_name, :genre_name)
  end

end
