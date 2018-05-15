module Dashboard
  class MessagesController < Dashboard::BaseController

    include Messageable

    def scoped_items
      Message.where(recipient_id: current_user.id).where.not(user_id: current_user.id)
    end
  end
end
