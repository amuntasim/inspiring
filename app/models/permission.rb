class Permission
  class << self
    def assigned_item_ids(user_id, item)
      redis.smembers(assigned_item_ids_set(user_id, item))
    end

    def set_assigned_item_ids(user_id, item_id, item)
      redis.sadd(assigned_item_ids_set(user_id, item), item_id)
    end

    def remove_assigned_item_ids(user_id, item_id, item)
      redis.srem(assigned_item_ids_set(user_id, item), item_id)
    end

    def item_permissions(user_id, item_id, item)
      redis.smembers(item_permissions_set(user_id, item_id, item))
    end

    def set_item_permissions(user_id, item_id, item, permissions)
      redis.sadd(item_permissions_set(user_id, item_id, item), permissions)
    end

    def remove_item_permissions(user_id, item_id, item, permissions)
      redis.srem(item_permissions_set(user_id, item_id, item), permissions)
    end

    def delete_item_permissions_key(user_id, item_id, item)
      redis.del(item_permissions_set(user_id, item_id, item))
    end

    private
    def redis
      $redis
    end

    def assigned_item_ids_set(user_id, item)
      "user_#{user_id}_assigned_#{item.underscore}_ids"
    end

    def item_permissions_set(user_id, item_id, item)
      "user_#{user_id}_#{item.underscore}_#{item_id}_permissions"
    end
  end

  module UserAccess
    def self.included(base)
      base.send :include, InstanceMethods
    end

    module InstanceMethods

      def manageable_brand_ids
        (Permission.assigned_item_ids(self.id, 'brand').collect(&:to_i)).compact
      end
    end
  end
end
