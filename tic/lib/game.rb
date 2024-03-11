# frozen_string_literal: true

require_relative 'win_cons'
# initializes the game, declares winner
class Game
  EMPTY_SPACE = 0
  NEW_BOARD = Array.new(3) { Array.new(3, EMPTY_SPACE) }
  include WinConditions

  attr_accessor :board, :player_one, :player_two, :turn_number, :winner

  def initialize(player_one, player_two)
    @player_one = player_one
    @player_two = player_two
    @board = NEW_BOARD
    @turn_number = 1
    @winner = false
  end

  def full?
    @board.all? do |row|
      row.all? { |cell| cell != EMPTY_SPACE }
    end
  end

  def mark_square(row, col, letter)
    @board[row][col] = letter unless @board[row][col] != EMPTY_SPACE
  end

  def bump_turn_number
    @turn_number += 1
  end

  def take_turn(player)
    puts self
    puts "Make your move, #{player}.\n\nEnter the desired row."
    row = gets.chomp.to_i
    puts 'Enter the column.'
    col = gets.chomp.to_i
    mark_square(row, col, player.letter)
    check_winner ? declare_winner(player) : false
    bump_turn_number
    cats_game? ? declare_tie : nil
  end

  def to_s
    @board.each do |row|
      readable = row.map do |square|
        case square
        when 1
          '[x]'
        when -1
          '[o]'
        else
          '[ ]'
        end
      end
      puts readable.join('')
    end
  end
end
