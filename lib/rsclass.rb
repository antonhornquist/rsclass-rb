module RSClass
	class <<self
		def parse_file(f)
			source = f[:source]
			type = source[:type]
			format = source[:format]
			name = source[:name]
			defn = eval "RSClass::Parse::parse__#{format}__to__#{type}(name, f[:content])"
			{
				"source" => {
					"type" => type,
					"format" => format,
					"name" => name
				},
				"definition" => defn
			}
		end

		def generate(repo_entry, rest_of_repo, dest_type)
			eval "RSClass::CodeGen::generate__#{dest_type}__from__#{repo_entry["source"]["type"]}(repo_entry, rest_of_repo)"
		end
	end
end

require 'rsclass/parse'
require 'rsclass/codegen'
