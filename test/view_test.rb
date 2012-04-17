require 'test_helper'

class ViewTest < ActiveSupport::TestCase
  class TestConstructor < Prospecto::View
    accepts :name, :age
  end

  test "auto generates a constructor" do
    assert TestConstructor.new(:name => "Bob", :age => 44).present?
  end

  test "auto generates attr_readers" do
    person = TestConstructor.new(:name => "Bob", :age => 44)
    assert_equal person.name, "Bob"
    assert_equal person.age, 44
  end
end
