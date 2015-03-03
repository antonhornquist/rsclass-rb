EXAMPLE_RB_STUB_1_CONTENT = <<'EOF'
class MyModule::ExampleClass < MyModule::ExampleSuperclass
	class << self
		attr_reader :readable_class_attribute
		attr_writer :writeable_class_attribute
		attr_accessor :accessable_class_attribute
	end

	@class_attribute_with_initial_value = "A string"

	attr_reader :readable_attribute
	attr_writer :writeable_attribute
	attr_accessor :accessable_attribute

	def initialize(init_argument_1, init_argument_2=:a_symbol, init_argument_3="A default string value")
		@attribute_with_initial_value = 4
	end

	# A comment

=begin
	Note:
	This is a comment spanning multiple lines.
=end

	def instance_method_without_argument
	end

	def instance_method_with_one_argument(argument)
	end

	def instance_method_with_two_arguments(argument_1, argument_2)
	end

	def instance_method_with_arguments_that_have_default_values(boolean_true_argument=true, boolean_false_argument=false, float_argument=3.14, string_argument="A default string value", symbol_argument=:a_default_symbol_value, nil_argument=nil)
	end

	def predicate_instance_method_with_two_arguments?(argument_1, argument_2)
	end

	def setter=(new_value)
	end

	def to_string
	end

	def instance_method_with_one_argument_and_method_bodies(argument)
		puts "Hello #{argument} from Ruby!"
		puts "Hello again from Ruby!"
	end

	def instance_method_with_sc_arguments_prefixed_with_arg(argument_1, argument_2)
	end

	def rb_method
	end

	def self.class_method_without_argument
	end

	def self.class_method_with_one_argument(argument)
	end

	def self.class_method_with_two_arguments(argument_1, argument_2)
	end

	def self.predicate_class_method_with_two_arguments?(argument_1, argument_2)
	end

	def self.class_setter=(new_value)
	end
end
EOF

EXAMPLE_RB_STUB_2_CONTENT = <<'EOF'
class MyModule::ExampleClass2
	CLASS_ATTRIBUTE = "test"
	READABLE_CLASS_ATTRIBUTE = :test

	attr_reader :readable_attribute

	def initialize(init_argument_1, init_argument_2=:a_symbol, init_argument_3="A string")
		@attribute = nil
		@readable_attribute = false
	end

end
EOF

EXAMPLE_RB_STUB_3_CONTENT = <<'EOF'
class MyModule::ExampleClass3
end
EOF

EXAMPLE_RB_STUB_4_CONTENT = <<'EOF'
class MyModule::ExampleClass4
	def initialize
	end

	def only_in_ruby
	end
end
EOF

EXAMPLE_RB_STUB_5_CONTENT = <<'EOF'
class MyModule::ExampleClass5
	attr_reader :rb_attribute

	def initialize
	end

	def an_attribute=(an_attribute)
	end
end
EOF

EXAMPLE_RB_STUB_1 = {
	:destination => {
		:filename => "example_class.rb",
		:filetype => "rb",
	},
	:content => EXAMPLE_RB_STUB_1_CONTENT
}

EXAMPLE_RB_STUB_2 = {
	:destination => {
		:filename => "example_class_2.rb",
		:filetype => "rb",
	},
	:content => EXAMPLE_RB_STUB_2_CONTENT
}

EXAMPLE_RB_STUB_3 = {
	:destination => {
		:filename => "example_class_3.rb",
		:filetype => "rb",
	},
	:content => EXAMPLE_RB_STUB_3_CONTENT
}

EXAMPLE_RB_STUB_4 = {
	:destination => {
		:filename => "example_class_4.rb",
		:filetype => "rb",
	},
	:content => EXAMPLE_RB_STUB_4_CONTENT
}

EXAMPLE_RB_STUB_5 = {
	:destination => {
		:filename => "example_class_5.rb",
		:filetype => "rb",
	},
	:content => EXAMPLE_RB_STUB_5_CONTENT
}
