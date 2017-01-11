# TODO: the ugly double assignments below are a quick way to suppress ruby warnings, eventually fix this in a better way
require 'rsclass/codegen_helper'

module RSClass::CodeGen
	class << self
		RB_STUB_TEMPLATE = <<'EOT'
class <%= "#{rb_modulename}::" if rb_modulename %><%= rb_classname %><%= " < #{"#{rb_modulename}::" if rb_modulename}#{rb_superclass}" if rb_superclass %>
<%= rb_class_constants %>
<%= rb_class_instance_variables %>
<%= rb_instance_variable_attribute_accessor_shortcuts %>
<%= rb_initialize_method %>
<%= rb_class_body %>
end
EOT
		
		RB_CLASS_INSTANCE_VARIABLES_TEMPLATE = <<EOT
<%= rb_class_instance_variable_attribute_accessor_shortcuts %>
<%= rb_class_instance_variable_attribute_initial_values %>
EOT
		
		RB_CLASS_INSTANCE_VARIABLE_ATTRIBUTE_ACCESSOR_SHORTCUT_TEMPLATE = <<EOT
	class << self
<%= rb_attribute_accessor_shortcuts %>
	end
EOT
		
		RB_ATTRIBUTE_ACCESSOR_SHORTCUT_TEMPLATE = <<EOT
<%= rb_accessor %> :<%= rb_attribute_name %>
EOT
		
		RB_METHOD_TEMPLATE = <<EOT
	def <%= rb_method_name %><%= rb_method_argument_declarations %>
<%= rb_method_body %>
	end
EOT
		
		RB_SINGLE_LINE_COMMENT_TEMPLATE = <<EOT
	# <%= rb_comment %>
EOT
		
		RB_MULTI_LINE_COMMENT_TEMPLATE = <<EOT
=begin
<%= rb_comment %>
=end
EOT
		
		def render_rb_attribute_accessor_shortcut(accessibility, name)
			rb_accessor = rb_accessor = case accessibility
				when "readable" then "attr_reader"
				when "accessable" then "attr_accessor"
				when "writeable" then "attr_writer"
				else raise "bad attribute accessibility for attribute name: #{name}, accessibility: #{accessibility}"
			end
			rb_attribute_name = rb_attribute_name = name
		
			apply_template(RB_ATTRIBUTE_ACCESSOR_SHORTCUT_TEMPLATE, binding)
		end
		
		def render_rb_class_constants(class_attributes)
			class_attributes_to_render = class_attributes.select { |attr| attr["render_as_rb_class_constant"] }
			class_attributes_to_render.map { |attr| "\t#{attr["name"].upcase} = #{render_rb_value(attr["initial_value"])}" }.join("\n") + "\n\n" unless class_attributes_to_render.empty?
		end
		
		def render_rb_class_instance_variables(class_attributes)
			rb_class_instance_variable_attribute_accessor_shortcuts = rb_class_instance_variable_attribute_accessor_shortcuts = render_rb_class_instance_variable_attribute_accessor_shortcuts(class_attributes)
			rb_class_instance_variable_attribute_initial_values = rb_class_instance_variable_attribute_initial_values = render_rb_class_instance_variable_attribute_initial_values(class_attributes)
			apply_template(RB_CLASS_INSTANCE_VARIABLES_TEMPLATE, binding)
		end
		
		def render_rb_class_instance_variable_attribute_accessor_shortcuts(class_attributes)
			class_attributes_to_render = class_attributes.select { |attr| attr["accessibility"] and not attr["render_as_rb_class_constant"] }
			unless class_attributes_to_render.empty?
				rb_attribute_accessor_shortcuts = rb_attribute_accessor_shortcuts = class_attributes_to_render.map { |attr| "\t\t" + render_rb_attribute_accessor_shortcut(attr["accessibility"], attr["name"]) }.join("\n") + "\n"
			
				apply_template(RB_CLASS_INSTANCE_VARIABLE_ATTRIBUTE_ACCESSOR_SHORTCUT_TEMPLATE, binding) + "\n"
			end
		end
		
		def render_rb_class_instance_variable_attribute_initial_values(class_attributes)
			class_attributes_to_render = class_attributes.select { |attr| attr["initial_value"] and not attr["render_as_rb_class_constant"] }
			class_attributes_to_render.map { |attr| "\t@#{attr["name"]} = #{render_rb_value(attr["initial_value"])}" }.join("\n") + "\n\n" unless class_attributes_to_render.empty?
		end
		
		def render_rb_instance_variable_attribute_accessor_shortcuts(instance_attributes)
			instance_attributes_to_render = instance_attributes.select { |attr| attr["accessibility"] }
			unless instance_attributes_to_render.empty?
				instance_attributes_to_render.map { |attr| "\t" + render_rb_attribute_accessor_shortcut(attr["accessibility"], attr["name"]) }.join("\n")+"\n\n"
			end
		end
		
		def render_rb_comment(str)
			rb_comment = str
			apply_template(rb_comment =~ /\n/ ? RB_MULTI_LINE_COMMENT_TEMPLATE : RB_SINGLE_LINE_COMMENT_TEMPLATE, binding)
		end
		
		def render_rb_value(defn_value)
			value = defn_value["value"]
			type = defn_value["type"]
			case type
			when "nil" then "nil"
			when "symbol" then ":#{value}"
			when "string" then ['"', '"'].join(value)
			else value
			end
		end
		
		def render_rb_argument_list(argument_list)
			if argument_list and not argument_list.empty?
				rb_argument_list = argument_list.map do |arg|
					rb_argument_name = arg["name"]
					default_value = arg["default_value"]
					if default_value
						"#{rb_argument_name}=#{render_rb_value(default_value)}"
					else
						rb_argument_name
					end
				end.join ', '
				"(#{rb_argument_list})"
			else
				""
			end
		end
		
		def render_rb_method(scope, name, arguments, body, opts={})
			rb_method_name = opts[:is_predicate] ? "#{name}?" : (opts[:is_setter] ? "#{name}=" : (opts[:is_cast_method] ? "to_#{name}" : name))
			rb_method_name = "self.#{rb_method_name}" if scope == "class"
			rb_method_argument_declarations = rb_method_argument_declarations = render_rb_argument_list(arguments)
			rb_method_body = rb_method_body = body ? body.split("\n").map { |line| "\t\t#{line}" }.join("\n") + "\n" : nil
			apply_template(RB_METHOD_TEMPLATE, binding)
		end
		
		def render_rb_class_body(methods, comments)
			combine_and_sort_class_body_content(methods, comments).map do |entry|
				case entry[:type]
				when :comment
					render_rb_comment(entry["text"])
				when :method
					render_rb_method(
						entry["scope"],
						entry["name"],
						entry["arguments"],
						entry["rb_method_body"],
						:is_getter => entry["is_getter"], :is_setter => entry["is_setter"], :is_predicate => entry["is_predicate"], :is_cast_method => entry["is_cast_method"], :only_in_sc => entry["only_in_sc"]
					)
				end
			end.join "\n"
		end
		
		def render_rb_initialize_method_body(instance_attributes)
			instance_attributes_with_initial_values = instance_attributes.select { |attr| attr["initial_value"] }
			instance_attributes_with_initial_values.empty? ? nil : (instance_attributes_with_initial_values.map { |attr| "@#{attr["name"]} = #{render_rb_value(attr["initial_value"])}" }.join("\n") + "\n")
		end
		
		def generate__rb_stub__from__rsclass(repo_entry, rest_of_repo)
			defn = repo_entry["definition"]
		
			modulename = defn["module"]
			classname = defn["classname"]
		
			superclass = defn["superclass"]
			init = defn["init"]
			members = defn["members"]
			instance_attributes, class_attributes = members["attributes"].reject { |atr| atr["only_in_sc"] }.partition { |atr| atr["scope"] == "instance" }
			methods = members["methods"].reject { |method| method["only_in_sc"] }
			documentation = defn["documentation"]
			comments = documentation["comments"]
		
			rb_modulename = rb_modulename = camelize(modulename)
			rb_classname = rb_classname = camelize(classname)
			rb_superclass = rb_superclass = camelize(superclass) if superclass
		
			rb_class_constants = rb_class_constants = render_rb_class_constants(class_attributes)
			rb_class_instance_variables = rb_class_instance_variables = render_rb_class_instance_variables(class_attributes)
			rb_instance_variable_attribute_accessor_shortcuts = rb_instance_variable_attribute_accessor_shortcuts = render_rb_instance_variable_attribute_accessor_shortcuts(instance_attributes)
			rb_initialize_method = rb_initialize_method = render_rb_method(
				"instance",
				"initialize",
				init["arguments"],
				render_rb_initialize_method_body(instance_attributes)
			) + "\n" if init["has_constructor"]
			rb_class_body = rb_class_body = render_rb_class_body(methods, comments)
		
			{
				:destination => {
					:filename => "#{classname}.rb",
					:filetype => "rb"
				},
				:content => apply_template(RB_STUB_TEMPLATE, binding)
			}
		end
	end
end
