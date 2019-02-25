module Api
  module SessionHelpers
    def session
      env['rack.session']
    end

    def login(user)
      session[:token] = user.result
      present('Successfully logged.')
    end

    def current_user
      @current_user ||= AuthorizeRequest.call(session[:token]).result if !session[:token].nil?
      @current_user || error!('Must login!', 401)
    end

    def logout
      if !session[:token].nil?
        session[:token] = nil
        present(message: 'Successfully logout.')
      else
        error!('Must login!', 401)
      end
    end

    def authorized!
      true
      # error!('Must login', 401) unless current_user
    end
  end
end
