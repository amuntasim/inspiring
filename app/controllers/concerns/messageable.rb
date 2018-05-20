module Messageable
  extend ActiveSupport::Concern

  included do
    before_action :set_message, only: [:show]
  end

  def index
    @messages = scoped_items.paginate(:page => params[:page], per_page: 10).order('created_at DESC')
  end

  def show
    @all_messages = if @message.parent_id
      Message.where(id: @message.parent_id).or(Message.where(parent_id: @message.parent_id)).order('created_at ASC')
    else
      [@message]
    end
    @base_message = @message.parent || @message
    if @message.user_id != current_user.id || @message.recipient_id.nil?
      @message.read!
    end
  end

  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    respond_to do |format|
      if @message.save
        format.js
      else
        format.js
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:brand_id, :reservation_id, :body, :parent_id, :recipient_id)
  end

  def set_message
    @message = scoped_items.find(params[:id])
  end
end
