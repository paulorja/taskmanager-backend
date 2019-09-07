require 'test_helper'

class StatusTest < ActiveSupport::TestCase

  test "should not save status without name" do
    status = Status.new
    assert_not status.save, "Saved the status without a name"
  end

  test "should save status with name" do
    status = Status.new
    status.name = "Done"
    assert status.save, "Didn't save the status with a name"
  end

end
