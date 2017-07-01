module MessagesHelper
  def messageType(user)
    if user == current_user
      "messageUser"
    else
      "messageOther"
    end
  end

  def messageSmallType(user)
    if user == current_user
      "right"
    else
      "left"
    end
  end
end
