class CreateInspirations < ActiveRecord::Migration[5.2]
  def change
    create_table :inspirations do |t|
      t.integer :user_id
      t.integer :inspiring_id
      t.string :inspiring_type

      t.timestamps
    end

    add_column :brands, :inspirations_count, :integer, default: 0
    add_column :stories, :inspirations_count, :integer, default: 0
    add_column :users, :inspirations_count, :integer, default: 0
    add_index :inspirations, :user_id
    add_index :inspirations, [:inspiring_id, :inspiring_type]
  end
end
