class AuthorizeRequest
  prepend SimpleCommand

  def initialize(token = {})
    @token = token
  end

  def call
    user
  end

  private

  attr_accessor :token

  def user
    @user ||= User.find(decode_token[:user_id]) if decode_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decode_token
    @decoded_auth_token ||= JsonWebToken.decode(token)
  end
end
