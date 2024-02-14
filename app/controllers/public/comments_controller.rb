class Public::CommentsController < ApplicationController

  def create
    @novel = Novel.find(params[:novel_id])
  if @novel
    comment = current_customer.comments.new(comment_params)
    comment.novel_id = @novel.id
    if comment.save
      redirect_to public_novel_path(@novel), notice: 'コメントが投稿されました。'
    else
    redirect_to public_novel_path(@novel), alert: 'コメントの投稿に失敗しました。'
    end
  else
   redirect_to public_novels_path, alert: '関連する小説が存在しません。'
  end
  end



  def destroy
    Comment.find_by(id: params[:id], novel_id: params[:novel_id]).destroy
    redirect_to request.referer
  end


   private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
