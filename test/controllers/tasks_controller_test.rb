require 'test_helper'

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:with_title)
  end

  test "should get index" do
    get tasks_url, as: :json
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post tasks_url, params: { task: { date: @task.date, description: @task.description, member_id: @task.member_id, priority_id: @task.priority_id, status_id: @task.status_id, title: @task.title } }, as: :json
    end

    assert_response 201
  end

  test "should not create tasks" do
    [tasks(:without_title), tasks(:without_relationship)].each do |task|
        @task = task
        assert_no_changes('Task.count') do
            post tasks_url, params: { task: { date: @task.date, description: @task.description, member_id: @task.member_id, priority_id: @task.priority_id, status_id: @task.status_id, title: @task.title } }, as: :json
        end
        assert_response 422
    end
  end

  test "should show task" do
    get task_url(@task), as: :json
    assert_response :success
  end

  test "should update task" do
    patch task_url(@task), params: { task: { date: @task.date, description: @task.description, member_id: @task.member_id, priority_id: @task.priority_id, status_id: @task.status_id, title: @task.title } }, as: :json
    assert_response 200
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete task_url(@task), as: :json
    end

    assert_response 204
  end
end
