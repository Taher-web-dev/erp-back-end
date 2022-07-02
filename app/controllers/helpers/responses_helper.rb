class Helpers::ApiException < StandardError
  def initialize(_status_code, error)
    super()
    @status_code = type
    @error = error
  end
end

class Helpers::Status
  @success = 'SUCCESS'
  @failed = 'FAILED'
  class << self
    attr_reader :success
  end

  class << self
    attr_reader :failed
  end
end

class Helpers::Error
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
