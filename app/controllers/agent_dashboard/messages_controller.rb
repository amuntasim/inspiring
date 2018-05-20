module AgentDashboard
  class MessagesController < AgentDashboard::BaseController

    include Messageable

    def scoped_items
      Message.where(brand_id: Story.manageable_brand_ids(current_user.id)).where.not(user_id: current_user.id)
    end
  end
end
