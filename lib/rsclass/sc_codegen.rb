# TODO: the ugly double assignments below are a quick way to suppress ruby warnings, eventually fix this in a better way
require 'rsclass/codegen_helper'

module RSClass::CodeGen
	class << self
		SC_STUB_TEMPLATE = <<'EOT'
<%= sc_classname %><%= " : #{sc_superclass}" if sc_superclass %> {
<%= sc_declaration_of_class_variables %>
<%= sc_declaration_of_instance_variables %>
<%= sc_new_class_method %>
<%= sc_init_instance_method %>
<%= sc_class_body %>
}
EOT

		SC_DECLARATION_OF_VARIABLES_TEMPLATE = <<EOT
	<%= sc_variable_declaration_type %>
		<%= sc_variable_names_with_getter_and_setter_specified %>
	;
EOT

		SC_METHOD_TEMPLATE = <<EOT
	<%= sc_method_name %> {<%= sc_method_argument_declarations %>
<%= sc_method_body %>
	}
EOT

		SC_NEW_CLASS_METHOD_BODY_TEMPLATE = <<EOT
^super.new.<%= sc_init_instance_method_name %><%= sc_init_arguments ? ["(", ")"].join(sc_init_arguments) : nil %>;
EOT

		SC_SINGLE_LINE_COMMENT_TEMPLATE = <<EOT
	// <%= sc_comment %>
EOT

		SC_MULTI_LINE_COMMENT_TEMPLATE = <<EOT
/*
<%= sc_comment %>
*/
EOT

		def render_sc_new_class_method_body(sc_classname, arguments)
			sc_init_instance_method_name = sc_init_instance_method_name = "init#{sc_classname}"
			sc_init_arguments = sc_init_arguments = arguments ? arguments.map { |arg| render_sc_argument(arg["name"], false) }.join(', ') : nil
			apply_template(SC_NEW_CLASS_METHOD_BODY_TEMPLATE, binding)
		end
		
		def render_sc_declaration_of_variables(scope, attributes)
			unless attributes.empty?
				sc_variable_declaration_type = sc_variable_declaration_type = (scope == :instance ? "var" : "classvar")
				sc_variable_names_with_getter_and_setter_specified = sc_variable_names_with_getter_and_setter_specified = attributes.map do |attr|
					name = attr["name"]
					accessibility = attr["accessibility"]
					initial_value = attr["initial_value"]
					case accessibility
						when "readable" then "<"
						when "accessable" then "<>"
						when "writeable" then ">"
						when nil then ""
						else raise "bad attribute accessibility for attribute name: #{name}, accessibility: #{accessibility}"
					end + camelize(name, false) + ((initial_value and initial_value["type"] != "nil") ? "=#{render_sc_value(initial_value)}" : "")
				end.join ",\n\t\t"
				apply_template(SC_DECLARATION_OF_VARIABLES_TEMPLATE, binding) + "\n"
			end
		end
		
		def render_sc_comment(str)
			sc_comment = str
			apply_template(sc_comment =~ /\n/ ? SC_MULTI_LINE_COMMENT_TEMPLATE : SC_SINGLE_LINE_COMMENT_TEMPLATE, binding)
		end
		
		def render_sc_argument(str, prefix_argument_with_arg)
			prefix_argument_with_arg ? "arg#{camelize(str)}" : camelize(str, false)
		end
		
		def render_sc_value(defn_value)
			value = defn_value["value"]
			type = defn_value["type"]
			case type
			when "symbol" then "\\#{camelize(value, false)}"
			when "string" then ['"', '"'].join(value)
			else value
			end
		end
		
		def render_sc_argument_list(argument_list, prefix_argument_with_arg)
			if argument_list and not argument_list.empty?
				sc_argument_list = argument_list.map do |arg|
					sc_argument_name = render_sc_argument(arg["name"], prefix_argument_with_arg)
					default_value = arg["default_value"]
					if default_value and default_value["type"] != "nil"
						sc_default_argument_value = render_sc_value(default_value)
						"#{sc_argument_name}=#{sc_default_argument_value}"
					else
						sc_argument_name
					end
				end.join ', '
				" |#{sc_argument_list}|"
			else
				""
			end
		end
		
		def render_sc_method(scope, name, arguments, body, opts={})
			sc_method_name = opts[:is_setter] ? camelize(name, false) + "_" : (opts[:is_cast_method] ? camelize("as_#{name}", false) : camelize(name, false))
			sc_method_name = "*#{sc_method_name}" if scope == "class"
			sc_method_argument_declarations = sc_method_argument_declarations = render_sc_argument_list(arguments, opts[:prefix_arguments_with_arg])
			sc_method_body = sc_method_body = body ? body.split("\n").map { |line| "\t\t#{line}" }.join("\n") + "\n" : nil
			apply_template(SC_METHOD_TEMPLATE, binding)
		end
		
		def render_sc_class_body(modulename, classname, methods, comments)
			combine_and_sort_class_body_content(methods, comments).map do |entry|
				case entry[:type]
				when :comment
					render_sc_comment(entry["text"])
				when :method
					methodname = if entry["is_sc_init_method"]
						"init_#{modulename}_#{classname}"
					else
						entry["name"]
					end
					render_sc_method(
						entry["scope"],
						methodname,
						entry["arguments"],
						entry["sc_method_body"],
						:is_getter => entry["is_getter"], :is_setter => entry["is_setter"], :is_predicate => entry["is_predicate"], :is_cast_method => entry["is_cast_method"], :prefix_arguments_with_arg => entry["prefix_sc_arguments_with_arg"]
					)
				end
			end.join "\n"
		end
		
		def generate__sc_stub__from__rsclass(repo_entry, rest_of_repo)
			defn = repo_entry["definition"]
		
			modulename = (defn["module_sc_abbreviation"] or defn["module"]) # TODO
			classname = defn["classname"]
		
			superclass = defn["superclass"]
			init = defn["init"]
			members = defn["members"]
			instance_attributes, class_attributes = members["attributes"].reject { |atr| atr["only_in_rb"] }.partition { |atr| atr["scope"] == "instance" }
			methods = members["methods"].reject { |method| method["only_in_rb"] }
			documentation = defn["documentation"]
			comments = documentation["comments"]
		
			sc_classname = camelize("#{modulename}_#{classname}")
			sc_superclass = sc_superclass = superclass ? camelize("#{modulename}_#{superclass}") : nil
			sc_declaration_of_class_variables = sc_declaration_of_class_variables = render_sc_declaration_of_variables(:class, class_attributes)
			sc_declaration_of_instance_variables = sc_declaration_of_instance_variables = render_sc_declaration_of_variables(:instance, instance_attributes)
		
			if init["has_constructor"]
				if init["sc_init_instance_method_with_same_arguments_as_new"]
					init_arguments_without_default_values = init["arguments"] ? init["arguments"].map { |arg| { "name" => arg["name"] } } : nil
			
					sc_init_instance_method_name = "init#{sc_classname}"
					sc_init_instance_method = sc_init_instance_method = render_sc_method(
						"instance",
						sc_init_instance_method_name,
						init_arguments_without_default_values,
						nil,
						:prefix_arguments_with_arg => true
					) + "\n"
					sc_new_class_method_body = render_sc_new_class_method_body(sc_classname, init_arguments_without_default_values)
				else
					sc_new_class_method_body = nil
				end
			
				sc_new_class_method = sc_new_class_method = render_sc_method(
					"class",
					"new",
					init["arguments"],
					sc_new_class_method_body,
					:prefix_arguments_with_arg => false
				) + "\n"
			end
		
			sc_class_body = sc_class_body = render_sc_class_body(modulename, classname, methods, comments)
		
			{
				:destination => {
					:filename => "#{sc_classname}.sc",
					:filetype => "sc"
				},
				:content => apply_template(SC_STUB_TEMPLATE, binding)
			}
		end
	end
end
