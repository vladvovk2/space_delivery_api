class UsersController < ActionController::Base
  def confirm_email
    user = User.find_by(confirm_token: params[:id])
    if user
      user.email_activate
      redirect_to confirm_email_user_path
    else
     
    end
  end
end
