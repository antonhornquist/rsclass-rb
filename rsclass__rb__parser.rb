class RsclassRbParser
	attr_accessor :result

	def initialize
		@result = {
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
		@ordinal = 1
	end

	# parser methods
	def has_classname(classname)
		@result["classname"] = classname.to_s
	end

	def is_subclass_of(classname)
		@result["superclass"] = classname.to_s
	end

	def belongs_to_module(modulename, opts={})
		@result["module"] = modulename.to_s
		@result["module_sc_abbreviation"] = opts[:sc_abbreviation] if opts[:sc_abbreviation] # TODO
	end

	def initializes_with(opts={})
		arguments = __parse_arguments_from_opts__(opts)
		@result["init"]["arguments"] = arguments if arguments
		@result["init"]["has_constructor"] = true
		[:sc_init_instance_method_with_same_arguments_as_new].each { |sym| @result["init"][sym.to_s] = true if opts[sym] }
	end

	def initializes_without_any_arguments(opts={})
		@result["init"]["has_constructor"] = true
		[:sc_init_instance_method_with_same_arguments_as_new].each { |sym| @result["init"][sym.to_s] = true if opts[sym] }
	end

	def has_readable_attribute(name, opts={})
		new_opts = opts.dup
		new_opts[:accessibility] = :readable
		has_attribute(name, new_opts)
	end

	def has_writeable_attribute(name, opts={})
		new_opts = opts.dup
		new_opts[:accessibility] = :writeable
		has_attribute(name, new_opts)
	end

	def has_accessable_attribute(name, opts={})
		new_opts = opts.dup
		new_opts[:accessibility] = :accessable
		has_attribute(name, new_opts)
	end

	def has_readable_class_attribute(name, opts={})
		new_opts = opts.dup
		new_opts[:accessibility] = :readable
		has_class_attribute(name, new_opts)
	end

	def has_writeable_class_attribute(name, opts={})
		new_opts = opts.dup
		new_opts[:accessibility] = :writeable
		has_class_attribute(name, new_opts)
	end

	def has_accessable_class_attribute(name, opts={})
		new_opts = opts.dup
		new_opts[:accessibility] = :accessable
		has_class_attribute(name, new_opts)
	end

	def has_class_attribute(name, opts={})
		new_opts = opts.dup
		new_opts[:scope] = :class
		has_attribute(name, new_opts)
	end

	def has_rb_attribute(name, opts={})
		new_opts = opts.dup
		new_opts[:only_in_rb] = true
		has_attribute(name, new_opts)
	end

	def has_sc_attribute(name, opts={})
		new_opts = opts.dup
		new_opts[:only_in_sc] = true
		has_attribute(name, new_opts)
	end

	def has_attribute(name, opts={})
		scope = (opts[:scope] or :instance)
		self.class.validate_scope(:attribute, name, scope)

		accessibility = opts[:accessibility]
		raise "bad attribute accessibility for name #{name} => accessibility #{accessibility}" unless [nil, :readable, :writeable, :accessable].include? accessibility

		atr = {}
		atr["ordinal"] = __next_ordinal__
		atr["name"] = name.to_s
		atr["scope"] = scope.to_s

		if opts.has_key?(:initial_value)
			opts_initial_value = opts[:initial_value]
			initial_value_type = nil
			initial_value = nil
			if opts_initial_value.is_a? Hash
				initial_value_type = opts_initial_value[:type]
				initial_value = opts_initial_value[:value]
			else
				initial_value = opts_initial_value
			end
			atr["initial_value"] = {
				"type" => initial_value_type ? initial_value_type.to_s : self.class.parse_value_type(initial_value),
				"value" => (initial_value.is_a? Symbol) ? initial_value.to_s : initial_value,
			}
		end
		atr["accessibility"] = accessibility.to_s if accessibility
		[
			:render_as_rb_class_constant,
			:only_in_rb,
			:only_in_sc,
		].each { |sym| atr[sym.to_s] = true if opts[sym] }
		@result["members"]["attributes"] << atr
	end

	def comment(text)
		@result["documentation"]["comments"] << { "ordinal" => __next_ordinal__, "text" => text }
	end

	def has_predicate(name, opts={})
		new_opts = opts.dup
		new_opts[:is_predicate] = true
		has_method(name, new_opts)
	end

	def has_setter(name, opts={})
		new_opts = opts.dup
		new_opts[:is_setter] = true
 		if not (new_opts[:arguments] or new_opts[:argument])
			new_opts[:arguments] = [name]
			new_opts[:prefix_sc_arguments_with_arg] = true
		end
		has_method(name, new_opts)
	end

	def has_cast_method(name, opts={})
		new_opts = opts.dup
		new_opts[:is_cast_method] = true
		has_method(name, new_opts)
	end

	def has_class_predicate(name, opts={})
		new_opts = opts.dup
		new_opts[:is_predicate] = true
		has_class_method(name, new_opts)
	end

	def has_class_setter(name, opts={})
		new_opts = opts.dup
		new_opts[:is_setter] = true
		has_class_method(name, new_opts)
	end

	def has_class_method(name, opts={})
		new_opts = opts.dup
		new_opts[:scope] = :class
		has_method(name, new_opts)
	end

	def has_rb_class_method(name, opts={})
		new_opts = opts.dup
		new_opts[:scope] = :class
		has_rb_method(name, new_opts)
	end

	def has_rb_method(name, opts={})
		new_opts = opts.dup
		new_opts[:only_in_rb] = true
		has_method(name, new_opts)
	end

	def has_sc_init_method(opts={})
		new_opts = opts.dup
		new_opts[:is_sc_init_method] = true
		has_sc_method(nil, new_opts)
	end

	def has_sc_class_method(name, opts={})
		new_opts = opts.dup
		new_opts[:scope] = :class
		has_sc_method(name, new_opts)
	end

	def has_sc_method(name, opts={})
		new_opts = opts.dup
		new_opts[:only_in_sc] = true
		has_method(name, new_opts)
	end

	def has_method(name, opts={})
		scope = (opts[:scope] or :instance)
		self.class.validate_scope(:method, name, scope)

		arguments = __parse_arguments_from_opts__(opts)

		meth = {}
		meth["ordinal"] = __next_ordinal__
		meth["name"] = name ? name.to_s : nil
		meth["scope"] = scope.to_s
		meth["arguments"] = arguments if arguments
		[
			:is_setter,
			:is_predicate,
			:is_cast_method,
			:only_in_rb,
			:only_in_sc,
			:prefix_sc_arguments_with_arg,
			:is_sc_init_method
		].each { |sym| meth[sym.to_s] = true if opts[sym] }

		[:rb_method_body, :sc_method_body].each do |sym|
			if opts[sym]
				method_body = opts[sym]
				meth[sym.to_s] = (method_body[0] == ?\n ? method_body[1..-1] : method_body)
			end
		end
		@result["members"]["methods"] << meth
	end

	# helper methods not used for parsing
	def __next_ordinal__
		return_value = @ordinal
		@ordinal = @ordinal.next
		return_value
	end

	def __parse_arguments_from_opts__(opts)
		arguments = ((opts[:argument] ? [opts[:argument]] : nil) or (opts[:arguments] ? opts[:arguments] : nil))
		arguments ? arguments.map do |arg|
			if arg.is_a? Hash
				def_name = nil
				def_dv_type = nil
				def_dv_value = nil
				if arg.size == 1
					def_name = arg.keys.first
					def_dv_value = arg.values.first
				else
					def_name = arg[:name] if arg[:name]
 					if arg[:default_value].is_a? Hash
						default_value_hash = arg[:default_value]
						def_dv_value = default_value_hash[:value] if default_value_hash[:value]
						def_dv_type = default_value_hash[:type] if default_value_hash[:type]
					else
						def_dv_value = arg[:default_value]
					end
				end
				{
					"name" => def_name.to_s,
					"default_value" => {
						"type" => def_dv_type ? def_dv_type.to_s : self.class.parse_value_type(def_dv_value),
						"value" => (def_dv_value.is_a? Symbol) ? def_dv_value.to_s : def_dv_value,
					}
				}
			else
				{
					"name" => arg.to_s
				}
			end
		end : nil
	end

	def self.parse_value_type(value)
		klass = value.class
		if klass == String then "string"
		elsif klass == Fixnum then "integer"
		elsif klass == Float then "float"
		elsif klass == Symbol then "symbol"
		elsif klass == TrueClass then "boolean"
		elsif klass == FalseClass then "boolean"
		elsif klass == NilClass then "nil"
		end
	end

	def self.validate_scope(member_type, name, scope)
		raise "bad scope for #{member_type} name #{name} => scope #{scope}" unless [:instance, :class].include? scope
	end

	alias :has_instance_attribute :has_attribute
	alias :has_instance_method :has_method
end

def parse__rb__to__rsclass(name, content)
	e = RsclassRbParser.new
	e.instance_eval(content)
	result = e.result
	result["classname"] = name unless result[:classname]
	result
end
