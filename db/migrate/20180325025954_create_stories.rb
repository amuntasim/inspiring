class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.integer :user_id
      t.integer :brand_id
      t.integer :category_id
      t.string :title
      t.text :description
      t.datetime :deleted_at
      t.timestamps
    end

    add_column :users, :stories_count, :integer, default: 0
    add_index :stories, :deleted_at
    add_index :stories, :category_id
  end
end
