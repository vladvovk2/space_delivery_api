module UsersHelper
  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      session[:user_id] = nil
      @current_user = nil
    end
  rescue ActiveRecord::RecordNotFound
    @current_user = nil
  ensure
    @current_user
  end
end
