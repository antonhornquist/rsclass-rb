require 'test/unit'
require 'rsclass'

require File.expand_path('../test_helper', __FILE__)
require File.expand_path('../mock_repo_files', __FILE__)
require File.expand_path('../mock_parsed_repo', __FILE__)
require File.expand_path('../mock_rb_stub_files', __FILE__)
require File.expand_path('../mock_sc_stub_files', __FILE__)

class TestModel < Test::Unit::TestCase
	def setup
	end

	def teardown
	end

	test "example 1 should be parsed correctly" do
		assert_equal(
			EXAMPLE_REPO_ENTRY_1,
			RSClass.parse_file(EXAMPLE_FILE_1)
		)
	end

	test "it should be possible to generate an rb stub from example 1" do
		# TODO puts EXAMPLE_RB_STUB_1
		# TODO puts generate(EXAMPLE_REPO_ENTRY_1, [], :rb_stub)
		assert_equal(
			EXAMPLE_RB_STUB_1,
			RSClass.generate(EXAMPLE_REPO_ENTRY_1, [], :rb_stub)
		)
	end

	test "it should be possible to generate an sc stub from example 1" do
		# TODO puts EXAMPLE_SC_STUB_1
		# TODO puts generate(EXAMPLE_REPO_ENTRY_1, [], :sc_stub)
		assert_equal(
			EXAMPLE_SC_STUB_1,
			RSClass.generate(EXAMPLE_REPO_ENTRY_1, [], :sc_stub)
		)
	end

	test "example 2 should be parsed correctly" do
		assert_equal(
			EXAMPLE_REPO_ENTRY_2,
			RSClass.parse_file(EXAMPLE_FILE_2)
		)
	end

	test "it should be possible to generate an rb stub from example 2" do
		# TODO puts EXAMPLE_RB_STUB_2
		# TODO puts generate(EXAMPLE_REPO_ENTRY_2, [], :rb_stub)
		assert_equal(
			EXAMPLE_RB_STUB_2,
			RSClass.generate(EXAMPLE_REPO_ENTRY_2, [], :rb_stub)
		)
	end

	test "it should be possible to generate an sc stub from example 2" do
		# TODO puts EXAMPLE_SC_STUB_2
		# TODO puts generate(EXAMPLE_REPO_ENTRY_2, [], :sc_stub)
		assert_equal(
			EXAMPLE_SC_STUB_2,
			RSClass.generate(EXAMPLE_REPO_ENTRY_2, [], :sc_stub)
		)
	end

	test "example 3 should be parsed correctly" do
		assert_equal(
			EXAMPLE_REPO_ENTRY_3,
			RSClass.parse_file(EXAMPLE_FILE_3)
		)
	end

	test "it should be possible to generate an rb stub from example 3" do
		# TODO puts EXAMPLE_RB_STUB_3
		# TODO puts generate(EXAMPLE_REPO_ENTRY_3, [], :rb_stub)
		assert_equal(
			EXAMPLE_RB_STUB_3,
			RSClass.generate(EXAMPLE_REPO_ENTRY_3, [], :rb_stub)
		)
	end

	test "it should be possible to generate an sc stub from example 3" do
		# TODO puts EXAMPLE_SC_STUB_3
		# TODO puts generate(EXAMPLE_REPO_ENTRY_3, [], :sc_stub)
		assert_equal(
			EXAMPLE_SC_STUB_3,
			RSClass.generate(EXAMPLE_REPO_ENTRY_3, [], :sc_stub)
		)
	end

	test "example 4 should be parsed correctly" do
		assert_equal(
			EXAMPLE_REPO_ENTRY_4,
			RSClass.parse_file(EXAMPLE_FILE_4)
		)
	end

	test "it should be possible to generate an rb stub from example 4" do
		# TODO puts EXAMPLE_RB_STUB_4
		# TODO puts generate(EXAMPLE_REPO_ENTRY_4, [], :rb_stub)
		assert_equal(
			EXAMPLE_RB_STUB_4,
			RSClass.generate(EXAMPLE_REPO_ENTRY_4, [], :rb_stub)
		)
	end

	test "it should be possible to generate an sc stub from example 4" do
		# TODO puts EXAMPLE_SC_STUB_4
		# TODO puts generate(EXAMPLE_REPO_ENTRY_4, [], :sc_stub)
		assert_equal(
			EXAMPLE_SC_STUB_4,
			RSClass.generate(EXAMPLE_REPO_ENTRY_4, [], :sc_stub)
		)
	end

	test "example 5 should be parsed correctly" do
		assert_equal(
			EXAMPLE_REPO_ENTRY_5,
			RSClass.parse_file(EXAMPLE_FILE_5)
		)
	end

	test "it should be possible to generate an rb stub from example 5" do
		# TODO puts EXAMPLE_RB_STUB_5
		# TODO puts generate(EXAMPLE_REPO_ENTRY_5, [], :rb_stub)
		assert_equal(
			EXAMPLE_RB_STUB_5,
			RSClass.generate(EXAMPLE_REPO_ENTRY_5, [], :rb_stub)
		)
	end

	test "it should be possible to generate an sc stub from example 5" do
		# TODO puts EXAMPLE_SC_STUB_5
		# TODO puts generate(EXAMPLE_REPO_ENTRY_5, [], :sc_stub)
		assert_equal(
			EXAMPLE_SC_STUB_5,
			RSClass.generate(EXAMPLE_REPO_ENTRY_5, [], :sc_stub)
		)
	end
end
