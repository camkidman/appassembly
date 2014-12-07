class PostsController < ApplicationController


  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_attributes)
    @post.fill_with_store_data
    redirect_to new_post_path, notice: "post created!"
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def upvote
    @post = Post.find(params[:id])
    @post.upvote_from current_user
    @post.update_aggregate
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @post.liked_count } }
    end
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_from current_user
    @post.update_aggregate
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @post.downvoted_count } }
    end
  end

  def post_confirmation
    @post = Post.find(params[:post_id])
  end

  private

  def post_attributes
    params.require(:post).permit(:store_type, :icon_url, :title, :store_url, :user_id)
  end

end
