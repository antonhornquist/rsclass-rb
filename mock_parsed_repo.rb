EXAMPLE_DEF_1 = {
	"classname"=>"example_class",
	"module"=>"my_module",
	"superclass"=>"example_superclass",
	"init"=>{
		"has_constructor"=>true,
		"arguments"=>[
			{
				"name" => "init_argument_1"
			},
			{
				"name" => "init_argument_2",
				"default_value" => {
					"type" => "symbol",
					"value" => "a_symbol",
				}
			},
			{
				"name" => "init_argument_3",
				"default_value" => {
					"type" => "string",
					"value" => "A default string value",
				}
			},
		]
	},
	"members"=>{
		"attributes"=>[
			{
				"ordinal" => 1,
				"name" => "attribute",
				"scope" => "instance"
			},
			{
				"ordinal" => 2,
				"name" => "readable_attribute",
				"accessibility" => "readable",
				"scope" => "instance"
			},
			{
				"ordinal" => 3,
				"name" => "writeable_attribute",
				"accessibility" => "writeable",
				"scope" => "instance"
			},
			{
				"ordinal" => 4,
				"name" => "accessable_attribute",
				"accessibility" => "accessable",
				"scope" => "instance"
			},
			{
				"ordinal" => 5,
				"name" => "class_attribute",
				"scope" => "class"
			},
			{
				"ordinal" => 6,
				"name" => "readable_class_attribute",
				"accessibility" => "readable",
				"scope" => "class"
			},
			{
				"ordinal" => 7,
				"name" => "writeable_class_attribute",
				"accessibility" => "writeable",
				"scope" => "class"
			},
			{
				"ordinal" => 8,
				"name" => "accessable_class_attribute",
				"accessibility" => "accessable",
				"scope" => "class"
			},
			{
				"ordinal" => 9,
				"name" => "attribute_with_initial_value",
				"initial_value" => {
					"value" => 4,
					"type" => "integer",
				},
				"scope" => "instance"
			},
			{
				"ordinal" => 10,
				"name" => "class_attribute_with_initial_value",
				"initial_value" => {
					"value" => "A string",
					"type" => "string",
				},
				"scope" => "class"
			},
		],
		"methods"=>[
			{
				"ordinal" => 13,
				"name" => "instance_method_without_argument",
				"scope" => "instance",
			},
			{
				"ordinal" => 14,
				"name" => "instance_method_with_one_argument",
				"scope" => "instance",
				"arguments" => [
					{
						"name" => "argument"
					},
				],
			},
			{
				"ordinal" => 15,
				"name" => "instance_method_with_two_arguments",
				"scope" => "instance",
				"arguments" => [
					{
						"name" => "argument_1"
					},
					{
						"name" => "argument_2"
					},
				],
			},
			{
				"ordinal" => 16,
				"name" => "instance_method_with_arguments_that_have_default_values",
				"scope" => "instance",
				"arguments" => [
					{
						"name" => "boolean_true_argument",
						"default_value" => {
							"type" => "boolean",
							"value" => true,
						}
					},
					{
						"name" => "boolean_false_argument",
						"default_value" => {
							"type" => "boolean",
							"value" => false,
						}
					},
					{
						"name" => "float_argument",
						"default_value" => {
							"type" => "float",
							"value" => 3.14,
						}
					},
					{
						"name" => "string_argument",
						"default_value" => {
							"type" => "string",
							"value" => "A default string value",
						}
					},
					{
						"name" => "symbol_argument",
						"default_value" => {
							"type" => "symbol",
							"value" => "a_default_symbol_value",
						}
					},
					{
						"name" => "nil_argument",
						"default_value" => {
							"type" => "nil",
							"value" => nil,
						}
					},
				]
			},
			{
				"ordinal" => 17,
				"name" => "predicate_instance_method_with_two_arguments",
				"scope" => "instance",
				"arguments" => [
					{
						"name" => "argument_1"
					},
					{
						"name" => "argument_2"
					},
				],
				"is_predicate" => true
			},
			{
				"ordinal" => 18,
				"name" => "setter",
				"scope" => "instance",
				"arguments" => [
					{
						"name" => "new_value"
					},
				],
				"is_setter" => true
			},
			{
				"ordinal" => 19,
				"name" => "string",
				"scope" => "instance",
				"is_cast_method" => true
			},
			{
				"ordinal" => 20,
				"name" => "instance_method_with_one_argument_and_method_bodies",
				"scope" => "instance",
				"arguments" => [
					{
						"name" => "argument"
					},
				],
				"rb_method_body" => %q{puts "Hello #{argument} from Ruby!"
puts "Hello again from Ruby!"
},
				"sc_method_body" => %q{"Hello % from SuperCollider!".format(argument).postln;
"Hello again from SuperCollider!".postln;
}
			},
			{
				"ordinal" => 21,
				"name" => "instance_method_with_sc_arguments_prefixed_with_arg",
				"scope" => "instance",
				"arguments" => [
					{
						"name" => "argument_1"
					},
					{
						"name" => "argument_2"
					},
				],
				"prefix_sc_arguments_with_arg" => true
			},
			{
				"ordinal" => 22,
				"name" => "sc_method",
				"scope" => "instance",
				"only_in_sc" => true,
			},
			{
				"ordinal" => 23,
				"name" => "rb_method",
				"scope" => "instance",
				"only_in_rb" => true,
			},
			{
				"ordinal" => 24,
				"name" => "class_method_without_argument",
				"scope" => "class",
			},
			{
				"ordinal" => 25,
				"name" => "class_method_with_one_argument",
				"scope" => "class",
				"arguments" => [
					{
						"name" => "argument"
					},
				],
			},
			{
				"ordinal" => 26,
				"name" => "class_method_with_two_arguments",
				"scope" => "class",
				"arguments" => [
					{
						"name" => "argument_1"
					},
					{
						"name" => "argument_2"
					},
				],
			},
			{
				"ordinal" => 27,
				"name" => "predicate_class_method_with_two_arguments",
				"scope" => "class",
				"arguments" => [
					{
						"name" => "argument_1"
					},
					{
						"name" => "argument_2"
					},
				],
				"is_predicate" => true
			},
			{
				"ordinal" => 28,
				"name" => "class_setter",
				"scope" => "class",
				"arguments" => [
					{
						"name" => "new_value"
					},
				],
				"is_setter" => true
			},
		],
	},
	"documentation"=>{
		"comments"=>
		[
			{
				"ordinal" => 11,
				"text" => "A comment",
			},
			{
				"ordinal" => 12,
				"text" => <<EOC
	Note:
	This is a comment spanning multiple lines.
EOC
			},
		]
	}
}

EXAMPLE_DEF_2 = {
	"classname"=>"example_class_2",
	"module"=>"my_module",
	"init"=>{
		"has_constructor"=>true,
		"arguments"=>[
			{
				"name" => "init_argument_1"
			},
			{
				"name" => "init_argument_2",
				"default_value" => {
					"type" => "symbol",
					"value" => "a_symbol",
				}
			},
			{
				"name" => "init_argument_3",
				"default_value" => {
					"type" => "string",
					"value" => "A string",
				}
			},
		],
		"sc_init_instance_method_with_same_arguments_as_new" => true
	},
	"members"=>{
		"attributes"=>[
			{
				"ordinal" => 1,
				"name" => "class_attribute",
				"scope" => "class",
				"initial_value" => {
					"type" => "string",
					"value" => "test"
				},
				"render_as_rb_class_constant" => true
			},
			{
				"ordinal" => 2,
				"name" => "readable_class_attribute",
				"scope" => "class",
				"accessibility" => "readable",
				"initial_value" => {
					"type" => "symbol",
					"value" => "test"
				},
				"render_as_rb_class_constant" => true
			},
			{
				"ordinal" => 3,
				"name" => "attribute",
				"scope" => "instance",
				"initial_value" => {
					"type" => "nil",
					"value" => nil
				},
			},
			{
				"ordinal" => 4,
				"name" => "readable_attribute",
				"scope" => "instance",
				"accessibility" => "readable",
				"initial_value" => {
					"type" => "boolean",
					"value" => false
				},
			},
		],
		"methods"=>[],
	},
	"documentation"=>{
		"comments"=>[],
	}
}

EXAMPLE_DEF_3 = {
	"classname"=>"example_class_3",
	"module"=>"my_module",
	"init"=>{
		"has_constructor"=>false,
	},
	"members"=>{
		"attributes"=>[],
		"methods"=>[],
	},
	"documentation"=>{
		"comments"=>[],
	}
}

EXAMPLE_DEF_4 = {
	"classname"=>"example_class_4",
	"module"=>"my_module",
	"init"=>{
		"has_constructor"=>true,
		"sc_init_instance_method_with_same_arguments_as_new" => true
	},
	"members"=>{
		"attributes"=>[],
		"methods"=>[
			{
				"ordinal" => 1,
				"name" => "only_in_ruby",
				"scope" => "instance",
				"only_in_rb" => true,
			},
			{
				"ordinal" => 2,
				"name" => "only_in_super_collider",
				"scope" => "instance",
				"only_in_sc" => true,
			},
		],
	},
	"documentation"=>{
		"comments"=>[],
	}
}

EXAMPLE_DEF_5 = {
	"classname"=>"example_class_5",
	"module"=>"my_module",
	"init"=>{
		"has_constructor"=>true,
	},
	"members"=>{
		"attributes"=>[
			{
				"ordinal" => 1,
				"name" => "an_attribute",
				"scope" => "instance"
			},
			{
				"ordinal" => 2,
				"name" => "rb_attribute",
				"scope" => "instance",
				"accessibility" => "readable",
				"only_in_rb" => true
			},
			{
				"ordinal" => 3,
				"name" => "sc_attribute",
				"scope" => "instance",
				"accessibility" => "readable",
				"only_in_sc" => true
			},
		],
		"methods"=>[
			{
				"ordinal" => 4,
				"name" => nil,
				"scope" => "instance",
				"only_in_sc" => true,
				"is_sc_init_method" => true,
				"arguments" => [
					{
						"name" => "test1"
					},
					{
						"name" => "test2"
					},
				],
			},
			{
				"ordinal" => 5,
				"name" => "an_attribute",
				"scope" => "instance",
				"arguments" => [
					{
						"name" => "an_attribute"
					},
				],
				"is_setter" => true,
				"prefix_sc_arguments_with_arg" => true
			},
		],
	},
	"documentation"=>{
		"comments"=>[],
	}
}

EXAMPLE_REPO_ENTRY_1 = {
	"source" => {
		"type" => "rsclass",
		"format" => "rb",
		"name" => "example_class",
	},
	"definition" => EXAMPLE_DEF_1
}

EXAMPLE_REPO_ENTRY_2 = {
	"source" => {
		"type" => "rsclass",
		"format" => "rb",
		"name" => "example_class_2",
	},
	"definition" => EXAMPLE_DEF_2
}

EXAMPLE_REPO_ENTRY_3 = {
	"source" => {
		"type" => "rsclass",
		"format" => "rb",
		"name" => "example_class_3",
	},
	"definition" => EXAMPLE_DEF_3
}

EXAMPLE_REPO_ENTRY_4 = {
	"source" => {
		"type" => "rsclass",
		"format" => "rb",
		"name" => "example_class_4",
	},
	"definition" => EXAMPLE_DEF_4
}

EXAMPLE_REPO_ENTRY_5 = {
	"source" => {
		"type" => "rsclass",
		"format" => "rb",
		"name" => "example_class_5",
	},
	"definition" => EXAMPLE_DEF_5
}
