require File.dirname(__FILE__) + '/../test_helper'
require 'rating_controller'

# Re-raise errors caught by the controller.
class RatingController; def rescue_action(e) raise e end; end

class RatingControllerTest < Test::Unit::TestCase
  def setup
    @controller = RatingController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
