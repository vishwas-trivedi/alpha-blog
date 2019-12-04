module CommnetsHelper
  def get_username(id)
    debugger
    user = User.find(id)
    debugger
    return user.username
  end
end
