
module AgentDashboard
  class BaseController < ApplicationController
    layout 'agent_dashboard'
    before_action :authenticate_user

    def authenticate_user
      unless current_user
        redirect_to root_path, alert: t('notifications.access_restricted')
      end
    end
  end
end
