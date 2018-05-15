class Role < ActiveRecord::Base
  enum access_level: { operator: 0, moderator: 1, administrator: 2 }

  validates :brand_id, presence: true
  validates :user_id, presence: true

  after_create :set_redis_data
  after_update :reset_redis_data
  before_destroy :remove_redis_data

  private
  def set_redis_data
    Permission.set_assigned_item_ids(user_id, brand_id, 'brand')
    Permission.set_item_permissions(user_id, brand_id, 'brand', permissions)
  end

  def reset_redis_data
    if brand_id_changed?
      Permission.remove_assigned_item_ids(user_id, brand_id_was, 'brand')
      Permission.delete_item_permissions_key(user_id, brand_id_was, 'brand')
    else
      remove_redis_data
    end
    set_redis_data
  end

  def remove_redis_data
    Permission.remove_assigned_item_ids(user_id, brand_id, 'brand')
    Permission.delete_item_permissions_key(user_id, brand_id, 'brand')
    true
  end
end
