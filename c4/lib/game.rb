# frozen_string_literal: true

# connect four board
class Game
  NUM_COLS = 7
  NUM_ROWS = 6
  attr_accessor :cols
  attr_reader :player_one, :player_two, :winner

  def initialize(player_one = Player.new, player_two = Player.new('p2', :black_square))
    @cols = Array.new(NUM_COLS) { Array.new(NUM_ROWS) }
    @player_one = player_one
    @player_two = player_two
    @winner = nil
  end

  def take_turn(player)
    move = player.input_move
    @cols[move] << player.token if legal?(move)
  end

  def legal?(move)
    (0..NUM_ROWS).include?(move) && !cols[move].all?
  end

  # def winning_position?
  #   row4? || col4? || diag4?
  # end

  # def game_over?
  #   full? || winning_position?
  # end
end
