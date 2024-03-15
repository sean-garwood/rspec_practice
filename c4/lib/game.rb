# frozen_string_literal: true

# connect four board
class Game
  include Board
  include WinConditions
  attr_accessor :cols, :winner
  attr_reader :player1, :player2

  ARGS = [
    EMPTY_BOARD,
    Player.new,
    Player.new('p2', :black_square),
    nil
  ].freeze
  def initialize(*args)
    @cols, @player1, @player2, @winner = args.empty? ? ARGS : args
  end

  def play
    take_turns until game_over?
    declare_winner
  end

  def take_turns
    take_turn(player1) unless game_over?

    take_turn(player2) unless game_over?
  end

  def game_over?
    full? || winning_position?
  end

  def take_turn(player)
    print_board
    col = player.input_move
    row = top_row(col)
    drop_token(col, row, player)
    set_winner(player)
  end

  def drop_token(col, row, player)
    @cols[col][row] = player.token if legal?(col)
  end

  def legal?(move)
    (0..NUM_ROWS).include?(move) && !full?(move)
  end

  def set_winner(player)
    @winner = player if winning_position?
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

  def declare_winner
    puts winner ? "#{winner} wins!" : 'It\'s a draw!'
  end
end
