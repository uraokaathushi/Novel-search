class Admin::NovelsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @novels = Novel.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def destroy_review
    @novel = Novel.find(params[:id])
    @novel.update(review: nil)
    redirect_to admin_novels_path
  end

end
