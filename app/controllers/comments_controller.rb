class CommentsController < ApplicationController

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
    @post = Post.find_by_id(params[:post_id])
  end

  def create
    @post = Post.find_by_id(params[:post_id])
    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      @comment = parent.children.build(comment_attributes)
    else
      @comment = Comment.new(comment_attributes)
    end

    if @comment.save
      redirect_to post_path(@post.id), notice: "Comment added!"
    else
      redirect_to :back, notice: "There was a problem adding your comment"
    end
  end

  private

  def comment_attributes
    params.require(:comment).permit(:body, :user_id, :post_id)
  end
end