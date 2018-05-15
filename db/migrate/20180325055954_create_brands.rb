class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :web
      t.text :description
      t.float :latitude
      t.float :longitude
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :brands, :deleted_at
    add_index :brands, :category_id
  end
end
