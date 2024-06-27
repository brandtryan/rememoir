require "test_helper"

class MemoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @memory = memories(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Memory.count' do
      post memories_path, params: { memory: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Memory.count' do
      delete memory_path(@memory)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong memory" do
    log_in_as(users(:michael))
    memory = memories(:ants)
    assert_no_difference 'Memory.count' do
      delete memory_path(memory)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end
end