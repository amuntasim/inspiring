class SpaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :category_id, :created_at, :updated_at
end
