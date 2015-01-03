class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  acts_as_votable

  def upvotes
    get_upvotes.size
  end

  def downvotes
    get_downvotes.size
  end

  def fill_with_store_data(data)
    update_attributes(title: data["results"].first["trackName"], store_type: "apple", store_url: data["results"].first["trackViewUrl"], icon_url: data["results"].first["artworkUrl60"] )
  end

  def update_aggregate
    update_attribute(:aggregate, (upvotes-downvotes))
  end


end
