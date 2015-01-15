class AddAverageUserRatingToPost < ActiveRecord::Migration
  def change
    add_column :posts, :average_user_rating, :integer
  end
end
