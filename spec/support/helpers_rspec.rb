module HelpersRspec
  def response_body
    JSON.parse(last_response.body, symbolize_names: true)
  end
end
