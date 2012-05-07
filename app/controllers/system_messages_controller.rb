class SystemMessagesController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_unread_system_message (in application_controller)

  # GET /system_messages
  # GET /system_messages.json
  def index
    mark_all_messages_read(@unread_system_messages)
  end

  def all_messages
    mark_all_messages_read(@unread_system_messages)
    @system_messages_recieved = @current_user.system_message_recieveds.find(:all,:order=>"created_at DESC")
    @system_messages_recieved = @system_messages_recieved.reject do |msg|
      @unread_system_messages.include?(msg)
    end
    @system_messages_sended = @current_user.system_message_sendeds.find(:all,:order=>"created_at DESC")
  end

  def ignore
    message = SystemMessage.find_by_id(params[:id])
    if message
      SystemMessage.mark_message_read(message.id)
    end
    redirect_to(:back)
  end

  private
  
  def redirect_back_unless condition
    unless condition
      flash[:error] = "invalid system message id"
      redirect_to(:back)
    end
  end
  def mark_all_messages_read messages
    messages.each do |msg|
      unless msg.message_type == "ask_friendship"
        SystemMessage.mark_message_read(msg.id)
        msg.is_read = true #in order to change the content in memory
      end
    end
  end
end
