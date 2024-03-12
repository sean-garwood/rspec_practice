# frozen_string_literal: true

# check game termination
module WinConditions
  EMPTY_SPACE = 0
  WIN_CON = 4
  NEW_BOARD = Array.new(WIN_CON) { Array.new(WIN_CON, EMPTY_SPACE) }
  def sum_diagonals
    sum_of_first_diag = 0
    sum_of_second_diag = 0
    board.each_with_index do |row, index|
      sum_of_first_diag += row[index]
      sum_of_second_diag += row[row.length - 1 - index]
    end
    [sum_of_first_diag.abs, sum_of_second_diag.abs]
  end

  def winning_row?(cols = nil)
    img = cols ? board.transpose : board
    img.each do |row|
      sum_of_row = row.reduce(0) { |sum, value| sum + value }
      return true if sum_of_row.abs == WIN_CON

      next
    end
    false
  end

  def winning_column?
    winning_row?(true)
  end

  def winning_diagonal?
    sum_diagonals.include?(WIN_CON)
  end

  def over?
    won? || cats_game?
  end

  def won?
    winning_column? || winning_diagonal? || winning_row?
  end

  def declare_winner(player)
    @winner = player
    puts("#{player} wins!")
    puts self
    exit
  end

  def cats_game?
    full? && !won?
  end

  def declare_tie
    puts('Tie game! Nobody wins.')
    exit
  end
end
