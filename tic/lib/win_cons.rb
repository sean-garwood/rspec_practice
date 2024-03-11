# frozen_string_literal: true

# check game termination
module WinConditions
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
    win = 3
    img.each do |row|
      sum_of_row = row.reduce(0) { |sum, value| sum + value }
      return true if sum_of_row.abs == win

      next
    end
    false
  end

  def winning_column?
    winning_row?(true)
  end

  def winning_diagonal?
    sum_diagonals.include?(3)
  end

  def over?
    @winner || cats_game?
  end

  def check_winner
    winning_column? || winning_diagonal? || winning_row?
  end

  def declare_winner(player)
    @winner = player
    puts("#{player} wins!")
    puts self
    exit
  end

  def cats_game?
    full? && !@winner
  end

  def declare_tie
    puts('Tie game! Nobody wins.')
    exit
  end
end
