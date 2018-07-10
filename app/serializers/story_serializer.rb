class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :category_id, :inspirations_count,
             :comments_count, :created_at, :updated_at, :photos
  belongs_to :user

  def photos
    object.photos.map do |photo|
      ::AttachmentSerializer.new(photo).attributes
    end
  end
end
