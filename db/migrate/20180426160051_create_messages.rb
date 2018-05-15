class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :parent_id
      t.text :body
      t.datetime :read_at
      t.integer :recipient_id
      t.integer :messageable_id
      t.string :messageable_type

      t.timestamps
    end

    add_index :messages, :user_id
    add_index :messages, [:messageable_id, :messageable_type]

  end
end
