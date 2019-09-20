class RemoveHostIdFromReviews < ActiveRecord::Migration[5.2]
  def change
    remove_column :reviews, :host_id
    remove_column :reviews, :type
    remove_column :reviews, :guest_id
    remove_column :reviews, :star
    remove_column :reviews, :room_id
    add_column :reviews, :score, :integer
    add_reference :reviews, :user
  end
end
