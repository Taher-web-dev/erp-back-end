class ApiException < StandardError
  def initialize(_status_code, error)
    super()
    @status_code = type
    @error = error
  end
end

class Status
  @success = 'SUCCESS'
  @failed = 'FAILED'
  class << self
    attr_reader :success
  end

  class << self
    attr_reader :failed
  end
end
