# frozen_string_literal: true

# check game termination
module WinConditions
  WIN_CON = 4

  def winning_position?
    winning?(:cols) || winning?(:rows) || winning?(:diagonals)
  end

  def winning?(lines)
    send(lines).each do |line|
      line.each_cons(WIN_CON) do |slice|
        return true if slice.uniq.length == 1 && !slice.uniq.first.nil?
      end
    end
    false
  end

  def winning_col?
    winning?(:cols)
  end

  def winning_row?
    winning?(:rows)
  end

  def winning_diag?
    winning?(:diagonals)
  end
end
