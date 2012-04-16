require 'test_helper'

class ViewTest < ActiveSupport::TestCase
  test "auto generates a constructor and attr_readers" do
    class TestConstructor < Prospecto::View
      accepts :name, :age
    end
    person = TestConstructor.new(:name => "Bob", :age => 44)
    assert_equal person.name, "Bob"
    assert_equal person.age, 44
  end
end
