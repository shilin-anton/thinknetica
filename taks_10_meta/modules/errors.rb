class NoValidation < StandardError
  def initialize(type)
    puts "Validation #{type} does not exists!"
    super
  end
end

class NotPresented < StandardError
  def initialize
    puts "Name is nil or empty string!"
    super
  end
end

class WrongTypeFormat < StandardError
  def initialize(arg)
    puts "Value does not match format #{arg}!"
    super
  end
end