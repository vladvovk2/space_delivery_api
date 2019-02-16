class AuthenticateUser
  prepend SimpleCommand

  def initialize(params)
    @phone_number    = params[:phone_number]
    @password = params[:password]
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :phone_number, :password

  def user
    user = User.find_by(phone_number: phone_number)
    return user if user&.authenticate(password)

    errors.add :user_authentication, 'Invalid data.'
  end
end
