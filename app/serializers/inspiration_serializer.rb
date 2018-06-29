class InspirationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :inspiring_id, :inspiring_type, :created_at
end
