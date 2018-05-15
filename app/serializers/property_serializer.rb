class PropertySerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :city_id, :category_id, :created_at, :updated_at
  has_many :spaces
end
