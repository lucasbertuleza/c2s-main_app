class ApplicationService
  def initialize
    raise NotImplementedError, "(ApplicationService is an abstract class and cannot be instantiated.)"
  end

  def self.call(...)
    # @sg-ignore
    new(...).call
  end
end
