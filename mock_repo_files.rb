EXAMPLE_FILE_1_CONTENT = <<'EOF'
has_classname :example_class
is_subclass_of :example_superclass
belongs_to_module :my_module

initializes_with :arguments => [
	:init_argument_1,
	{
		:init_argument_2=>:a_symbol
	},
	{
		:name=>:init_argument_3,
		:default_value=> {
			:value=>"A default string value",
			:type=>"string",
		}
	}
]

has_attribute :attribute
has_readable_attribute :readable_attribute
has_writeable_attribute :writeable_attribute
has_accessable_attribute :accessable_attribute
has_class_attribute :class_attribute
has_readable_class_attribute :readable_class_attribute
has_writeable_class_attribute :writeable_class_attribute
has_accessable_class_attribute :accessable_class_attribute

has_attribute :attribute_with_initial_value, :initial_value => 4
has_class_attribute :class_attribute_with_initial_value, :initial_value => "A string"

comment "A comment"

comment <<EOC
	Note:
	This is a comment spanning multiple lines.
EOC

has_method :instance_method_without_argument

has_method :instance_method_with_one_argument, :argument => :argument

has_method :instance_method_with_two_arguments, :arguments => [:argument_1, :argument_2]

has_method :instance_method_with_arguments_that_have_default_values, :arguments => [
	{:boolean_true_argument => true},
	{:boolean_false_argument => false},
	{:float_argument=>3.14},
	{:string_argument=>"A default string value"},
	{:symbol_argument=>:a_default_symbol_value},
	{:nil_argument=>nil}
]

has_predicate :predicate_instance_method_with_two_arguments, :arguments => [:argument_1, :argument_2]

has_setter :setter, :argument => :new_value

has_cast_method :string

has_method :instance_method_with_one_argument_and_method_bodies, :argument => :argument,
	:rb_method_body => %q{
puts "Hello #{argument} from Ruby!"
puts "Hello again from Ruby!"
},
	:sc_method_body => %q{
"Hello % from SuperCollider!".format(argument).postln;
"Hello again from SuperCollider!".postln;
}


has_method :instance_method_with_sc_arguments_prefixed_with_arg, :arguments => [:argument_1, :argument_2], :prefix_sc_arguments_with_arg => true

has_method :sc_method, :only_in_sc => true

has_method :rb_method, :only_in_rb => true

has_class_method :class_method_without_argument

has_class_method :class_method_with_one_argument, :argument => :argument

has_class_method :class_method_with_two_arguments, :arguments => [:argument_1, :argument_2]

has_class_predicate :predicate_class_method_with_two_arguments, :arguments => [:argument_1, :argument_2]

has_class_setter :class_setter, :argument => :new_value
EOF

EXAMPLE_FILE_2_CONTENT = <<'EOF'
has_classname :example_class_2
belongs_to_module :my_module

initializes_with :arguments => [
	:init_argument_1,
	{
		:init_argument_2=>:a_symbol
	},
	{
		:init_argument_3=>"A string"
	}
], :sc_init_instance_method_with_same_arguments_as_new => true

has_class_attribute :class_attribute, :initial_value => "test", :render_as_rb_class_constant => true
has_readable_class_attribute :readable_class_attribute, :initial_value => :test, :render_as_rb_class_constant => true

has_attribute :attribute, :initial_value => nil
has_readable_attribute :readable_attribute, :initial_value => false
EOF

EXAMPLE_FILE_3_CONTENT = <<'EOF'
has_classname :example_class_3
belongs_to_module :my_module
EOF

EXAMPLE_FILE_4_CONTENT = <<'EOF'
has_classname :example_class_4
belongs_to_module :my_module
initializes_without_any_arguments :sc_init_instance_method_with_same_arguments_as_new => true
has_rb_method :only_in_ruby
has_sc_method :only_in_super_collider
EOF

EXAMPLE_FILE_5_CONTENT = <<'EOF'
belongs_to_module :my_module
has_attribute :an_attribute
has_rb_attribute :rb_attribute, :accessibility => :readable
has_sc_attribute :sc_attribute, :accessibility => :readable
initializes_without_any_arguments
has_sc_init_method :arguments => [:test1, :test2]
has_setter :an_attribute
EOF

EXAMPLE_FILE_1 = {
	:source => {
		:type => "rsclass",
		:format => "rb",
		:name => "example_class",
	},
	:content => EXAMPLE_FILE_1_CONTENT
}

EXAMPLE_FILE_2 = {
	:source => {
		:type => "rsclass",
		:format => "rb",
		:name => "example_class_2",
	},
	:content => EXAMPLE_FILE_2_CONTENT
}

EXAMPLE_FILE_3 = {
	:source => {
		:type => "rsclass",
		:format => "rb",
		:name => "example_class_3",
	},
	:content => EXAMPLE_FILE_3_CONTENT
}

EXAMPLE_FILE_4 = {
	:source => {
		:type => "rsclass",
		:format => "rb",
		:name => "example_class_4",
	},
	:content => EXAMPLE_FILE_4_CONTENT
}

EXAMPLE_FILE_5 = {
	:source => {
		:type => "rsclass",
		:format => "rb",
		:name => "example_class_5",
	},
	:content => EXAMPLE_FILE_5_CONTENT
}
