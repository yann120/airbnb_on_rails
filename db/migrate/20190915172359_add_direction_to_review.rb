class AddDirectionToReview < ActiveRecord::Migration[5.2]
  def change
	add_column :reviews, :direction, :string 
  end
end
