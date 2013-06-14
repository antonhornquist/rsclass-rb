require 'rsclass__rb_stub__generator'
require 'rsclass__sc_stub__generator'

def generate(repo_entry, rest_of_repo, dest_type)
	eval "generate__#{dest_type}__from__#{repo_entry["source"]["type"]}(repo_entry, rest_of_repo)"
end
