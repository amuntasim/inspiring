class DashboardController < ApplicationController

  before_action :prepare_dashboard
  def index
     render   layout: 'dashboard'
  end

  def agent_index
    render   layout: 'agent_dashboard'
  end

  private

  def prepare_dashboard

  end
end
