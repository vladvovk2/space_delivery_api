class UsersController < ActionController::Base
  def confirm_email
    user = User.find_by(confirm_token: params[:id])
    if user
      user.email_activate
      flash[:success] = 'Your email has been confirmed.'
      redirect_to confirm_email_user_path
    else
      flash[:error] = 'Sorry. User does not exist'
      # redirect_to root_url
    end
  end
end
