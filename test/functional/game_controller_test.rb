require 'test_helper'

class GameControllerTest < ActionController::TestCase
  test "redirect of atom" do
    get :atom
    assert_redirected_to :controller => 'games', :action => 'atom'
  end
end
