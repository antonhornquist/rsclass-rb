require 'rsclass__rb__parser'

def parse_file(f)
	source = f[:source]
	type = source[:type]
	format = source[:format]
	name = source[:name]
	defn = eval "parse__#{format}__to__#{type}(name, f[:content])"
	{
		"source" => {
			"type" => type,
			"format" => format,
			"name" => name
		},
		"definition" => defn
	}
end
