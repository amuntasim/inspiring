class Tagging < ::ActiveRecord::Base #:nodoc:

  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  validates_presence_of :tag_id
  validates_uniqueness_of :tag_id, scope: [:taggable_type, :taggable_id]

  scope :for_properties, -> {where(taggable_type: 'Property')}
  scope :for_spaces, -> {where(taggable_type: 'Space')}
end
