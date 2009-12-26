require 'test_helper'

class TeamGamesControllerTest < ActionController::TestCase
  fixtures :team_games

  def setup
    @controller = TeamGamesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  test "index" do
    get :index
    assert_response :success
    assert_template 'list'
  end

  test "list" do
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:team_games)
  end

  test "show" do
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:team_game)
    assert assigns(:team_game).valid?
  end

  test "new" do
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:team_game)
  end

  test "create" do
    num_team_games = TeamGame.count

    post :create, :team_game => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_team_games + 1, TeamGame.count
  end

  test "edit" do
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:team_game)
    assert assigns(:team_game).valid?
  end

  test "update" do
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  test "destroy" do
    assert_not_nil TeamGame.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      TeamGame.find(1)
    }
  end
end
