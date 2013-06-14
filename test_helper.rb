require 'test/unit'

class Test::Unit::TestCase
	def self.test(name, &block)
    test_name = "test: #{name} ".to_sym
    defined = instance_method(test_name) rescue false
    raise "#{test_name} is already defined in #{self}" if defined
    define_method(test_name, &block)
  end
end
