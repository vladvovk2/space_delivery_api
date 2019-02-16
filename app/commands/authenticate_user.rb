class AuthenticateUser
  prepend SimpleCommand

  def initialize(params)
    @password     = params[:password]
    @phone_number = params[:phone_number]
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
