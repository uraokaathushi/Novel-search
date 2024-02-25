class Admin::NovelsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:method]
      @content = params[:content]
      @method = params[:method]
      @novels = Novel.search_for(@content, @method).page(params[:page]).per(10)
    else
    @novels = Novel.all.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def destroy
    @novel = Novel.find(params[:id])
    @novel.destroy
    redirect_to admin_path, notice: "小説を削除しました。"
  end


  def destroy_review
    @novel = Novel.find(params[:id])
    @novel.update(review: nil)
    redirect_to admin_novels_path
  end

end
