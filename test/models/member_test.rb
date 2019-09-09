require 'test_helper'

class MemberTest < ActiveSupport::TestCase

  test "should not save member without name" do
    member = Member.new
    assert_not member.save, "Saved the member without a name"
  end

  test "should save member with name" do
    member = Member.new
    member.name = "Done"
    assert member.save, "Didn't save the member with a name"
  end

end
