require 'erb'

def apply_template(template_name, variable_and_method_bindings)
	ERB.new(template_name, 0, "%<>").result(variable_and_method_bindings)
end

def combine_and_sort_class_body_content(methods, comments)
	(
		(methods.map { |e| new_entry=e.dup; new_entry[:type] = :method; new_entry }) +
		(comments.map { |e| new_entry=e.dup; new_entry[:type] = :comment; new_entry })
	).sort_by { |hash| hash["ordinal"] }
end
