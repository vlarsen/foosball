require File.dirname(__FILE__) + '/../test_helper'
require 'matrix_controller'

# Re-raise errors caught by the controller.
class MatrixController; def rescue_action(e) raise e end; end

class MatrixControllerTest < Test::Unit::TestCase
  
  fixtures :games
  
  def setup
    @controller = MatrixController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_versus
    assert_equal Game.count, 3
    @controller.score_versus
    assert_equal @controller.versus_hash['vlarsen']['gv'].wins, 0
    assert_equal @controller.versus_hash['gv']['vlarsen'].wins, 1
  end
end
