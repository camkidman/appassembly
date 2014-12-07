class Post < ActiveRecord::Base
  belongs_to :user
  acts_as_votable

  def aggregate=(value)
    value = upvotes - downvotes
    write_attribute(:attribute_name, value)
  end

  def upvotes
    get_upvotes.size
  end

  def downvotes
    get_downvotes.size
  end


end
