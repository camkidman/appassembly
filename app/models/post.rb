class Post < ActiveRecord::Base
  belongs_to :user
  acts_as_votable

  def upvotes
    get_upvotes.size
  end

  def downvotes
    get_downvotes.size
  end

  def fill_with_store_data
    response = JSON.parse(HTTParty.get(store_url))
    update_attribute(:title, response["results"].first["trackName"])
  end

  def update_aggregate
    update_attribute(:aggregate, (upvotes-downvotes))
  end


end
