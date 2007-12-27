require File.dirname(__FILE__) + '/../test_helper'
require 'team_games_controller'

# Re-raise errors caught by the controller.
class TeamGamesController; def rescue_action(e) raise e end; end

class TeamGamesControllerTest < Test::Unit::TestCase
  fixtures :team_games

  def setup
    @controller = TeamGamesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:team_games)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:team_game)
    assert assigns(:team_game).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:team_game)
  end

  def test_create
    num_team_games = TeamGame.count

    post :create, :team_game => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_team_games + 1, TeamGame.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:team_game)
    assert assigns(:team_game).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil TeamGame.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      TeamGame.find(1)
    }
  end
end
