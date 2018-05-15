module UserRoles
  include ActiveSupport::Concern

  def admin?
    role == User::ADMIN_ROLE
  end

  def property_owner?
    role == User::PROPERTY_OWNER_ROLE || properties_count > 0
  end
end