class PostsController < ApplicationController


  def new
    @post = Post.new
  end

  def create
    itunes_store_id = params[:post][:store_id]
    itunes_response = JSON.parse(HTTParty.get("https://itunes.apple.com/lookup?id=#{itunes_store_id}"))
    puts "blah" + itunes_response.inspect
    @post = Post.new(store_id: itunes_store_id)
    if @post.save
      @post.fill_with_store_data(itunes_response)
      redirect_to new_post_path, notice: "post created!"
    elsif existing_post = Post.find_by_store_id(@post.store_id)
      redirect_to existing_post_path(existing_post.id)
    else
      render 'new', notice: "There was a problem creating your post"
    end

  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.hash_tree
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

  def existing
    @post = Post.find(params[:id])
  end

  private

  def post_attributes
    params.require(:post).permit(:store_type, :icon_url, :title, :store_url, :user_id, :store_id, :description, :average_user_rating)
  end

end
