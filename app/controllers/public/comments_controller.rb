class Public::CommentsController < ApplicationController
  
  def create
    novel = Novel.find(params[:novel_id])
  if novel
    comment = current_customer.novel_comments.new(comment_params)
    comment.novel_id = novel.id
    comment.save
  else
  flash[:error] = "関連する小説が存在しません。"
  end
    redirect_to public_novel_psth(novel)
  end     
    
    
  def index
    
  end
  
  def destroy
    
  end
  
  
   private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
