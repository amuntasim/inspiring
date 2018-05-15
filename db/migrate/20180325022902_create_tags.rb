class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :category
      t.timestamps
    end

    add_index :tags, :category

    create_table "taggings", force: :cascade do |t|
      t.integer "tag_id", limit: 4
      t.integer "taggable_id", limit: 4
      t.string "taggable_type", limit: 255
      t.datetime "created_at"
    end

    add_index :taggings, [:tag_id, :taggable_id, :taggable_type]

    create_table "categories", force: :cascade do |t|
      t.string :name, null: false
      t.string :for, null: false
      t.integer :items_count, :integer, default: 0
      t.datetime "created_at", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

  end
end
