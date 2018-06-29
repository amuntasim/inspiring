class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :handle, :avatar_url

  def avatar_url
    object.cover_photo.attached? ? object.cover_photo :  scope.image_url("thumb/avatar.jpg")
  end
end
