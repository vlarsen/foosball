require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_response :success
    assert_template 'list'
  end

  test "list" do
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:games)
  end

  test "show" do
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:game)
    assert assigns(:game).valid?
  end

  test "new" do
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:game)
  end

  test "create" do
    num_games = Game.count

    post :create, :game => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_games + 1, Game.count
  end

  test "edit" do
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:game)
    assert assigns(:game).valid?
  end

  test "update" do
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  test "destroy" do
    assert_not_nil Game.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Game.find(1)
    }
  end
end
