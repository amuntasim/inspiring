
module AgentDashboard
  class BaseController < ApplicationController
    layout 'agent_dashboard'

    before_action :authenticate_property_owner

    def authenticate_property_owner
      unless current_user && current_user.property_owner?
       redirect_to root_path, alert: t('notifications.access_restricted')
      end
    end
  end
end
