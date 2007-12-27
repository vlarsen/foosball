require File.dirname(__FILE__) + '/../test_helper'
require 'game_controller'

# Re-raise errors caught by the controller.
class GameController; def rescue_action(e) raise e end; end

class GameControllerTest < Test::Unit::TestCase
  def setup
    @controller = GameController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_redirect_of_atom
    get :atom
    assert_redirected_to :controller => 'games', :action => 'atom'
  end
end
