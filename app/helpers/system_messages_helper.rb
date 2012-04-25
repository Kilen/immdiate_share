module SystemMessagesHelper
  def system_message_interpreter message_type
    case message_type
    when "share": msg = "shared something with "
    when "comment": msg = "commented on"
    when "reply": msg = "replied to"
    when "ask_friendship": msg = "want(s) to be friend with"
    when "agree_friendship": msg = "agree(s) to be friend with"
    else
      raise "no such message_type"
    end
    return msg
  end
end
