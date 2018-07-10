class AttachmentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :url

  def url
    rails_blob_url(object)
  end
end
