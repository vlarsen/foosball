=begin
Do calculations based on the pair matrix of players.
=end
class MatrixController < ApplicationController
  layout "games"

  attr_reader :versus_hash

  # Calculate the pairwise score and side/color use.
  def score_versus
    @all_players = Array.new
    @versus_hash = Hash.new do |vh, vk|
      vh[vk] = Hash.new do |h, k|
        h[k] = Versus.new(vk, k)
      end
    end
    Game.find(:all, :order => "played_at").each do |thegame|
      @all_players << thegame.red  unless @all_players.include?(thegame.red )
      @all_players << thegame.blue unless @all_players.include?(thegame.blue)
      red_versus_blue = @versus_hash[thegame.red][thegame.blue]
      blue_versus_red = @versus_hash[thegame.blue][thegame.red]

      red_versus_blue.process_result(thegame)
      blue_versus_red.process_result(thegame)
    end
    @all_players.sort!
    @rows = @all_players
    @columns = @all_players
    if params.has_key?(:id)
      @versus_hash.delete_if {|k,v| k != params[:id]}
      @all_players.delete_if {|e| not @versus_hash[params[:id]].key?(e)}
      @rows = Array.new
      @rows << params[:id]
      @columns = @all_players
    end
  end

end
