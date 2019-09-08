require 'test_helper'

class TaskTransferTest < ActiveSupport::TestCase

  test "should not transfer to invalid status" do
    prepare_tasks
    task = Task.find_by_title("task-todo-1")
    invalid_status_id = 99
    assert_not(task.transfer(1, invalid_status_id))
  end

  test "should transfer from todo-1 to done-1" do
    prepare_tasks
    done = Status.find_by_name("done")
    assert_transfer("task-todo-1", 1, done.id)
  end

  test "should not transfer from todo-1 to done-2" do
    prepare_tasks
    done = Status.find_by_name("done")
    task = Task.find_by_title("task-todo-1")
    assert_not(task.transfer(2, done.id))
  end

  test "should transfer from todo-3 to done-1" do
    prepare_tasks
    todo = Status.find_by_name("todo")
    done = Status.find_by_name("done")
    task = Task.find_by_title("task-todo-3")
    assert_transfer("task-todo-3", 1, done.id)
    assert_position_and_status("task-todo-4", 3, todo.id)
  end

  test "scene 2 - should transfer from done-2 to todo-1" do
    prepare_tasks_scene_2
    todo = Status.find_by_name("todo")
    done = Status.find_by_name("done")

    task = Task.find_by_title("task-done-2")
    assert_transfer("task-done-2", 1, todo.id)

    assert_position_and_status("task-todo-1", 2, todo.id)
    assert_position_and_status("task-done-1", 1, done.id)
    assert_position_and_status("task-done-3", 2, done.id)
  end

  private 

  def assert_transfer(title, position, status_id)
    task = Task.find_by_title(title)
    assert(task.transfer(position, status_id))
    assert_position_and_status(task.title, position, status_id)
  end

  def assert_position_and_status(title, expected_position, expected_status_id)
    task = Task.find_by_title(title)
    assert_equal(task.position, expected_position)
    assert_equal(task.status_id, expected_status_id)
  end

  def prepare_tasks
    Task.destroy_all
    Status.destroy_all

    todo = Status.create(name: "todo")
    done = Status.create(name: "done")

    create_task("task-todo-1", todo)
    create_task("task-todo-2", todo)
    create_task("task-todo-3", todo)
    create_task("task-todo-4", todo)
  end

  def prepare_tasks_scene_2
    Task.destroy_all
    Status.destroy_all

    todo = Status.create(name: "todo")
    done = Status.create(name: "done")

    create_task("task-todo-1", todo)

    create_task("task-done-1", done)
    create_task("task-done-2", done)
    create_task("task-done-3", done)
  end

  def create_task(title, status)
    Task.create({
        title: title,
        member: Member.first,
        status: status,
        priority: Priority.first
    })
  end

end