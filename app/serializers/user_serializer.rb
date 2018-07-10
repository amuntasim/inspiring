class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :handle, :avatar_url, :cover_photo_url

  def avatar_url
    object.avatar.attached? ? rails_blob_url(object.avatar) :  scope.image_url("thumb/avatar.jpg")
  end

  def cover_photo_url
    object.cover_photo.attached? ? rails_blob_url(object.cover_photo) :  scope.image_url("thumb/sample_cover_photo.jpg")
  end

end
