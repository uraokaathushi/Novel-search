class Public::NovelsController < ApplicationController

  def new
    @novel = Novel.new
  end

  def create
    @novel = Novel.new(params[:id])
    @novel.customer_id = current_customer
    @novel.save
    redirect_to  public_customer_my_page_path
  end

  def index
    @novel = Novel.all
  end

  def show
    @novel = Novel.find(params[:id])
  end

  def edit
    @novel = Novel.find_by(id: params[:id])
     if @novel.nil?
      redirect_to public_novel_path(@novel)
     else
      render :index
     end
  end

  def update
   @novel = Novel.find(params[:id])
   if @novel.update(novel_params)
   redirect_to public_novel_path(@novel)
   else
    render :edit
   end
  end


  private

  def novel_params
    params.require(:novel).permit(:title, :review, :site_name, :genre_name)
  end


end
