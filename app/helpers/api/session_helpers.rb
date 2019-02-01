module Api
  module SessionHelpers
    def session
      env['rack.session']
    end
  end
end