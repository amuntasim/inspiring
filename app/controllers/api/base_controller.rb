module Api
  class BaseController < ActionController::API
    include Response
    include ExceptionHandler

    # called before every action on controllers
    before_action :set_current_user
    before_action :authorize_request!
    attr_reader :current_user
    serialization_scope :view_context

    private

    def set_current_user
      @current_user = warden&.user || (AuthorizeApiRequest.new(request.headers).call)[:user]
    end

    def authorize_request!
      raise ExceptionHandler::AuthenticationError unless current_user
    end

    def pagination_dict(collection)
      {
          per_page:      collection.per_page,
          current_page:  collection.current_page,
          next_page:     collection.next_page,
          prev_page:     collection.previous_page,
          total_pages:   collection.total_pages,
          total_records: collection.total_entries
      }
    end
  end
end
