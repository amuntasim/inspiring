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

  def localized_field_name(field)
    ['i18n', I18n.locale, field].join('_')
  end

  def active_navigation(_controller='dashboard', _action=nil)
    'active' if _controller == controller_name && (_action ? _action == action_name : true)
  end

  def after_sign_in_path
    if session[:draft_reservation_id]
      preview_reservation_path(id: session[:draft_reservation_id])
    elsif session[:pending_property_id]
      Story.where(user_id: nil, id: session[:pending_property_id]).update_all(user_id: current_user.id)
      session[:pending_property_id] = nil
      agent_dashboard_properties_path
    elsif current_user.admin?
      '/admin'
    else
      dashboard_path
    end
  end

  def fix_language_switch
    if (session[:previous_request_method].to_s == 'post')
      return "alert('#{t('label.language_switching_not_allowed')}'); return false;"
    end
    return 'return true;'
  end

  def localized_url(preferred = 'en')
    current_url = request.url

    if current_url.match(/locale=(\w+)*/)
      current_url = current_url.gsub(/locale=(\w+)*/, 'locale=' + preferred)
    else
      if current_url.match(/\?/)
        current_url = current_url << '&locale='+ preferred
      else
        current_url = current_url << '?locale='+ preferred
      end
    end
    current_url
  end

  def ltr_rtl
    [:ar].include?(I18n.locale) ? 'rtl' : 'ltr'
  end

end
