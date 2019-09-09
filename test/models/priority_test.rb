require 'test_helper'

class PriorityTest < ActiveSupport::TestCase

  test "should not save priority without name" do
    priority = Priority.new
    assert_not priority.save, "Saved the priority without a name"
  end

  test "should save priority with name" do
    priority = Priority.new
    priority.name = "Done"
    assert priority.save, "Didn't save the priority with a name"
  end

end
