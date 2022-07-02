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
EMPLOYEE_NOT_FOUND = Error.new('Employee', 102, 'Employee not found')
BODY_PARAMETRS = Error.new('Body', 99, 'Body parametrs are missing or empty')
MISSING_REQUIRED_PARAMETRS = Error.new('Missing Parametrs', 100, 'Missing required parametr')
