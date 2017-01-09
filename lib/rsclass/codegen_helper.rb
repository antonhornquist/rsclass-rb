require 'erb'

module RSClass::CodeGen
	class << self
		def apply_template(template_name, variable_and_method_bindings)
			ERB.new(template_name, 0, "%<>").result(variable_and_method_bindings)
		end
		
		def combine_and_sort_class_body_content(methods, comments)
			(
				(methods.map { |e| new_entry=e.dup; new_entry[:type] = :method; new_entry }) +
				(comments.map { |e| new_entry=e.dup; new_entry[:type] = :comment; new_entry })
			).sort_by { |hash| hash["ordinal"] }
		end

		def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
			words = lower_case_and_underscored_word.split('_')
			if first_letter_in_uppercase
				words.map {|e| e.capitalize}.join
			else
				words.first + camelize(words[1..-1].join('_'))
			end
		end
	end
end
