class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table "roles", force: true do |t|
      t.integer  "created_by_id"
      t.integer  "user_id"
      t.integer  "brand_id"
      t.integer   "access_level"
      t.datetime "created_at",    null: false
      t.datetime "updated_at",    null: false
      t.index [:brand_id, :user_id]
    end
  end
end
