class Post < ActiveRecord::Base
  belongs_to :user
  acts_as_votable

  def upvotes
    get_upvotes.size
  end

  def downvotes
    get_downvotes.size
  end


end
