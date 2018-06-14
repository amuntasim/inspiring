class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :story
      t.integer :user_id
      t.integer :replies_count, default: 0
      t.text :body
      t.references :parent

      t.timestamps
    end

    add_column :stories, :comments_count, :integer, default: 0
  end
end
