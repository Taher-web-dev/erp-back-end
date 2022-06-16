class ApiException < StandardError
  def initialize(status_code, error)
    super()
    @status_code = type
    @error = error
  end
end

class Status
    @@success = 'SUCCESS'
    @@failed = 'FAILED'
    def self.success
        @@success
    end
    def self.failed
        @@failed
    end
end