require 'test_helper'

class TaskMoveTest < ActiveSupport::TestCase

  test "should add the position automatically" do
    prepare_tasks
    assert_equal(Task.first.position, 1)
    assert_equal(Task.last.position, 5)
  end

  test "should not move to same position" do
    prepare_tasks
    assert_not(Task.find_by_title("task 2").move(2))
  end

  test "should move task from 2 to 3" do
    prepare_tasks
    assert(Task.find_by_title("task 2").move(3))
    assert_position("task 2", 3)
    assert_position("task 3", 2)
  end

  test "should move task from 4 to 3" do
    prepare_tasks
    assert(Task.find_by_title("task 4").move(3))
    assert_position("task 4", 3)
    assert_position("task 3", 4)
  end

  test "should move task from 1 to 3" do
    prepare_tasks
    assert(Task.first.move(3))
    assert_position("task 2", 1)
    assert_position("task 3", 2)
    assert_position("task 1", 3)
    assert_position("task 4", 4)
    assert_position("task 5", 5)
  end

  test "should move task from 0 to invalid" do
    prepare_tasks
    assert_not(Task.first.move(6))
    assert_not(Task.first.move(0))
    assert_not(Task.first.move(-1))
  end

  test "should move task from 5 to 2" do
    prepare_tasks
    assert(Task.last.move(2))
    assert_position("task 1", 1)
    assert_position("task 5", 2)
    assert_position("task 2", 3)
    assert_position("task 3", 4)
    assert_position("task 4", 5)
  end

  test "should move task from 2 to 4" do
    prepare_tasks
    assert(Task.find_by_title("task 2").move(4))
    assert_position("task 1", 1)
    assert_position("task 3", 2)
    assert_position("task 4", 3)
    assert_position("task 2", 4)
    assert_position("task 5", 5)
  end

  test "should move task from 4 to 2" do
    prepare_tasks
    assert(Task.find_by_title("task 4").move(2))
    assert_position("task 1", 1)
    assert_position("task 4", 2)
    assert_position("task 2", 3)
    assert_position("task 3", 4)
    assert_position("task 5", 5)
  end

  private 

  def assert_position(title, position)
    assert_equal(Task.find_by_title(title).position, position)
  end

  def prepare_tasks
    Task.destroy_all
    create_task("task 1")
    create_task("task 2")
    create_task("task 3")
    create_task("task 4")
    create_task("task 5")
  end

  def create_task(title)
    Task.create({
        title: title,
        member: Member.first,
        status: Status.first,
        priority: Priority.first
    })
  end

end
