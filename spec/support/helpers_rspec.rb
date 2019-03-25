module HelpersRspec
  def response_body
    JSON.parse(last_response.body, symbolize_names: true)
  end

  def auth_error
    {
      code: 'NOT_AUTHORIZED',
      message: 'Invalid email or password'
    }
  end
end
