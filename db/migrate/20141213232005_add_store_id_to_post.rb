class AddStoreIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :store_id, :integer
  end
end
