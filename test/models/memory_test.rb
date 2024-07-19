require "test_helper"

class MemoryTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @memory = @user.memories.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @memory.valid?
  end

  test "user id should be present" do
    @memory.user_id = nil
    assert_not @memory.valid?
  end

  test "content should be present" do
    @memory.content = "   "
    assert_not @memory.valid?
  end

  test "content should be at most 500 characters" do
    @memory.content = "a" * 501
    assert_not @memory.valid?
  end

  test "order should be most recent first" do
    assert_equal memories(:most_recent), Memory.first
  end
end
