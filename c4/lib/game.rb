# frozen_string_literal: true

require_relative 'player'
# connect four board
class Game
  NUM_COLS = 7
  NUM_ROWS = 6
  EMPTY_BOARD = Array.new(NUM_COLS) { Array.new(NUM_ROWS) }
  ARGS = [
    EMPTY_BOARD,
    Player.new,
    Player.new('p2', :black_square),
    nil
  ].freeze
  attr_accessor :cols, :winner
  attr_reader :player1, :player2

  def initialize(*args)
    @cols, @player1, @player2, @winner = args.empty? ? ARGS : args
    # lemmy_speaks
  end

  def top_row(col)
    cols[col].any? ? cols[col].compact.size : 0
  end

  def take_turn(player)
    col = player.input_move
    row = top_row(col)
    @cols[col][row] = player.token if legal?(col)
  end

  def legal?(move)
    (0..NUM_ROWS).include?(move) && !full?(move)
  end

  def full?(column = nil)
    return cols.all?(&:all?) unless column
    return true if column > NUM_COLS || column.negative?

    cols[column].all?
  end

  def play
    take_turns until winner || game_over?
  end

  def take_turns
    # puts "board: #{cols}"
    take_turn(player1) unless game_over?
    # puts "board: #{cols}"
    take_turn(player2) unless game_over?
  end

  # def winning_position?
  #   row4? || col4? || diag4?
  # end

  def game_over?
    full? || winner
  end

  private

  def lemmy_speaks
    puts <<~HEREDOC
      It's time to play THE GAME...Connect 4. I'm your host, Lemmy.

      It's a bloody fine thing, Connect 4, and it's bloody good that you're
      here to enjoy it with me, Lemmy Kilmeister, deceased lead singer and
      bassist for the iconic English hard rock band, M\u00F6torhead.

      What say we get to it, then?
    HEREDOC
  end
end

# Game.new.play
