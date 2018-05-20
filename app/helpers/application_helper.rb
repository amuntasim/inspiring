module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def active_navigation(_controller='dashboard', _action=nil)
    'active' if _controller == controller_name && (_action ? _action == action_name : true)
  end

  def after_sign_in_path
    if current_user.admin?
      '/admin'
    else
      dashboard_path
    end
  end
end
