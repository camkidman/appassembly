class AddAggregateToPost < ActiveRecord::Migration
  def change
    add_column :posts, :aggregate, :integer
  end
end
