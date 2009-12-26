require 'test_helper'

class MatrixControllerTest < ActionController::TestCase
  
  def setup
    @controller = MatrixController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  test "versus" do
    assert_equal Game.count, 3
    @controller.score_versus
    assert_equal @controller.versus_hash['vlarsen']['gv'].wins, 0
    assert_equal @controller.versus_hash['gv']['vlarsen'].wins, 1
  end
end
