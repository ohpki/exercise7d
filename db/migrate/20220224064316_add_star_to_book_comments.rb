class AddStarToBookComments < ActiveRecord::Migration[6.1]
  def change
    add_column :book_comments, :ster, :float
  end
end
