class CreateSocialLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :social_links do |t|
      t.string :social_linkable_type
      t.string :social_linkable_id
      t.string :name
      t.string :url

      t.timestamps
    end

    add_index :social_links, [:social_linkable_type, :social_linkable_id], name: :social_linkable
  end
end
