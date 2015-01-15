class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  acts_as_votable

  validates_uniqueness_of :store_id

  def upvotes
    get_upvotes.size
  end

  def downvotes
    get_downvotes.size
  end

  def fill_with_store_data(data)
    update_attributes(title: data["results"].first["trackName"], store_type: "apple", store_url: data["results"].first["trackViewUrl"], icon_url: data["results"].first["artworkUrl60"], description: data["results"].first["description"], average_user_rating: data["results"].first["averageUserRating"] )
  end

  def update_aggregate
    update_attribute(:aggregate, (upvotes-downvotes))
  end


end
