module Api
  module SessionHelpers
    def session
      env['rack.session']
    end

    def login(user)
      session[:token] = user.result
      { message: 'Successfully logged ' }
    end

    def current_user
      if !session[:token].nil?
        AuthorizeRequest.call(session[:token]).result
      else
        error!('Must login!', 404)
      end
    end

    def logout
      if !session[:token].nil?
        session[:token] = nil
        { message: 'Successfully logout.' }
      else
        error!('Must login!', 404)
      end
    end
  end
end
