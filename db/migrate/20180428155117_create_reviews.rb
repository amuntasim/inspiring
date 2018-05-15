class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :reviewable_id
      t.string :reviewable_type
      t.integer :rating
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
    add_index :reviews, [:reviewable_id, :reviewable_type]
    add_index :reviews, :user_id

    add_column :brands, :reviews_count, :integer, default: 0
    add_column :brands, :avg_rating, :float, default: 0
  end
end
