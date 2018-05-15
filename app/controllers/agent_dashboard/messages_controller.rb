module AgentDashboard
  class MessagesController < AgentDashboard::BaseController

    include Messageable

    def scoped_items
      Message.where(property_id: Story.manageable_property_ids(current_user.id)).where.not(user_id: current_user.id)
    end
  end
end
