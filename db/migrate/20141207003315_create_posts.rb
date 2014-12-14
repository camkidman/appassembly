class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :store_url
      t.string :store_type
      t.string :icon_url
      t.references :user, index: true

      t.timestamps
    end
  end
end
