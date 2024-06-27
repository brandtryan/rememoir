require "test_helper"

class MemoriesInterface < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    log_in_as(@user)
  end
end

class MemoriesInterfaceTest < MemoriesInterface

  test "should paginate memories" do
    get root_path
    assert_select 'div.pagination'
  end

  test "should show errors but not create memory on invalid submission" do
    assert_no_difference 'Memory.count' do
      post memories_path, params: { memory: { content: "" } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'  # Correct pagination link
  end

  test "should create a memory on valid submission" do
    content = "This memory really ties the room together"
    assert_difference 'Memory.count', 1 do
      post memories_path, params: { memory: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
  end

  test "should have memory delete links on own profile page" do
    get users_path(@user)
    assert_select 'a', text: 'delete'
  end

  test "should be able to delete own memory" do
    first_memory = @user.memories.paginate(page: 1).first
    assert_difference 'Memory.count', -1 do
      delete memory_path(first_memory)
    end
  end

  test "should not have delete links on other user's profile page" do
    get user_path(users(:archer))
    assert_select 'a', { text: 'delete', count: 0 }
  end
end