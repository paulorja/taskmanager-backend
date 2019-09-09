require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test "should not save task without relationship" do
    task = tasks(:without_relationship)
    assert_not task.save, "Saved the task without a relationship"
  end

  test "should not save task without title" do
    task = tasks(:without_title)
    assert_not task.save, "Saved the task without a title"
  end

  test "should save task with title" do
    task = tasks(:with_title)
    assert task.save, "Didn't save the task with a title"
  end

end
