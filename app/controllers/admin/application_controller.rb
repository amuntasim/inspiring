# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin

    def index
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(scoped_resource, dashboard_class, search_term).run
      resources = order.apply(resources)
      resources = resources.paginate(:page => params[:page])
      page = Administrate::Page::Collection.new(dashboard, order: order)

      render locals: {
                 resources: resources.paginate(:page => params[:page]),
                 search_term: search_term,
                 page: page,
                 show_search_bar: show_search_bar?
             }
    end

    def authenticate_admin
      unless current_user && current_user.admin?
       redirect_to root_path, alert: t('notifications.access_restricted')
      end
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
