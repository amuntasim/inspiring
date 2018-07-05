class CreateUsedPoints < ActiveRecord::Migration[5.2]
  def change
    create_table :used_points do |t|
      t.integer :user_id
      t.integer :points
      t.string :reference_type
      t.integer :reference_id
      t.string :note

      t.timestamps
    end

    add_column :users, :inspiration_points, :integer, default: 0
    add_column :users, :used_points_count, :integer, default: 0
  end
end
