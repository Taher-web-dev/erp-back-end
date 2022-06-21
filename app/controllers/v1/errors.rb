class Error
  def initialize(type, code, message)
    @type = type
    @code = code
    @message = message
    display_error(type, code, message)
  end

  private

  def display_error(type, code, message)
    { type:, code:, message: }
  end
end

USER_NOT_FOUND = Error.new('User', 101, 'User not found')
BODY_PARAMETRS = Error.new('Body', 99, 'Params is missing or the value is empty: user')
MISSING_REQUIRED_PARAMETRS = Error.new('Missing Parametrs', 100, 'Missing required parametr')