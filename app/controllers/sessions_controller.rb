class SessionsController < ApplicationController
  def create
    @user = User
            .find_by(phone_number: "+380#{params[:phone_number]}")
            .try(:authenticate, params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to blogs_path
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
