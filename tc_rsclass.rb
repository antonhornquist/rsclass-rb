require 'test/unit'
require 'test_helper'
require 'rsclass'

require 'mock_repo_files'
require 'mock_parsed_repo'
require 'mock_rb_stub_files'
require 'mock_sc_stub_files'

class TestModel < Test::Unit::TestCase
	def setup
	end

	def teardown
	end

	test "example 1 should be parsed correctly" do
		assert_equal(
			EXAMPLE_REPO_ENTRY_1,
			parse_file(EXAMPLE_FILE_1)
		)
	end

	test "it should be possible to generate an rb stub from example 1" do
		# TODO puts EXAMPLE_RB_STUB_1
		# TODO puts generate(EXAMPLE_REPO_ENTRY_1, [], :rb_stub)
		assert_equal(
			EXAMPLE_RB_STUB_1,
			generate(EXAMPLE_REPO_ENTRY_1, [], :rb_stub)
		)
	end

	test "it should be possible to generate an sc stub from example 1" do
		# TODO puts EXAMPLE_SC_STUB_1
		# TODO puts generate(EXAMPLE_REPO_ENTRY_1, [], :sc_stub)
		assert_equal(
			EXAMPLE_SC_STUB_1,
			generate(EXAMPLE_REPO_ENTRY_1, [], :sc_stub)
		)
	end

	test "example 2 should be parsed correctly" do
		assert_equal(
			EXAMPLE_REPO_ENTRY_2,
			parse_file(EXAMPLE_FILE_2)
		)
	end

	test "it should be possible to generate an rb stub from example 2" do
		# TODO puts EXAMPLE_RB_STUB_2
		# TODO puts generate(EXAMPLE_REPO_ENTRY_2, [], :rb_stub)
		assert_equal(
			EXAMPLE_RB_STUB_2,
			generate(EXAMPLE_REPO_ENTRY_2, [], :rb_stub)
		)
	end

	test "it should be possible to generate an sc stub from example 2" do
		# TODO puts EXAMPLE_SC_STUB_2
		# TODO puts generate(EXAMPLE_REPO_ENTRY_2, [], :sc_stub)
		assert_equal(
			EXAMPLE_SC_STUB_2,
			generate(EXAMPLE_REPO_ENTRY_2, [], :sc_stub)
		)
	end

	test "example 3 should be parsed correctly" do
		assert_equal(
			EXAMPLE_REPO_ENTRY_3,
			parse_file(EXAMPLE_FILE_3)
		)
	end

	test "it should be possible to generate an rb stub from example 3" do
		# TODO puts EXAMPLE_RB_STUB_3
		# TODO puts generate(EXAMPLE_REPO_ENTRY_3, [], :rb_stub)
		assert_equal(
			EXAMPLE_RB_STUB_3,
			generate(EXAMPLE_REPO_ENTRY_3, [], :rb_stub)
		)
	end

	test "it should be possible to generate an sc stub from example 3" do
		# TODO puts EXAMPLE_SC_STUB_3
		# TODO puts generate(EXAMPLE_REPO_ENTRY_3, [], :sc_stub)
		assert_equal(
			EXAMPLE_SC_STUB_3,
			generate(EXAMPLE_REPO_ENTRY_3, [], :sc_stub)
		)
	end

	test "example 4 should be parsed correctly" do
		assert_equal(
			EXAMPLE_REPO_ENTRY_4,
			parse_file(EXAMPLE_FILE_4)
		)
	end

	test "it should be possible to generate an rb stub from example 4" do
		# TODO puts EXAMPLE_RB_STUB_4
		# TODO puts generate(EXAMPLE_REPO_ENTRY_4, [], :rb_stub)
		assert_equal(
			EXAMPLE_RB_STUB_4,
			generate(EXAMPLE_REPO_ENTRY_4, [], :rb_stub)
		)
	end

	test "it should be possible to generate an sc stub from example 4" do
		# TODO puts EXAMPLE_SC_STUB_4
		# TODO puts generate(EXAMPLE_REPO_ENTRY_4, [], :sc_stub)
		assert_equal(
			EXAMPLE_SC_STUB_4,
			generate(EXAMPLE_REPO_ENTRY_4, [], :sc_stub)
		)
	end

	test "example 5 should be parsed correctly" do
		assert_equal(
			EXAMPLE_REPO_ENTRY_5,
			parse_file(EXAMPLE_FILE_5)
		)
	end

	test "it should be possible to generate an rb stub from example 5" do
		# TODO puts EXAMPLE_RB_STUB_5
		# TODO puts generate(EXAMPLE_REPO_ENTRY_5, [], :rb_stub)
		assert_equal(
			EXAMPLE_RB_STUB_5,
			generate(EXAMPLE_REPO_ENTRY_5, [], :rb_stub)
		)
	end

	test "it should be possible to generate an sc stub from example 5" do
		# TODO puts EXAMPLE_SC_STUB_5
		# TODO puts generate(EXAMPLE_REPO_ENTRY_5, [], :sc_stub)
		assert_equal(
			EXAMPLE_SC_STUB_5,
			generate(EXAMPLE_REPO_ENTRY_5, [], :sc_stub)
		)
	end
end
