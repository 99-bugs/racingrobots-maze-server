require 'minitest/assertions'

module Minitest::Assertions
  # Check if string contains substring
  def assert_string_contains(expected_substring, actual_string)
    assert actual_string.include?(expected_substring), 
      "Expected #{ expected_substring.inspect } was not found in #{ actual_string.inspect }"
  end
end