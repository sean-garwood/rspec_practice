# frozen_string_literal: true

# check game termination
module WinConditions
  WIN_CON = 4

  def winning_condition?
    winning_col? || winning_row? || winning_diag?
  end

  def winning_col?
    cols.each do |col|
      col.each_cons(WIN_CON) do |slice|
        return true if slice.uniq.length == 1 && !slice.uniq.first.nil?
      end
    end
    false
  end

  def winning_row?
    rows.each do |row|
      row.each_cons(WIN_CON) do |slice|
        return true if slice.uniq.length == 1 && !slice.uniq.first.nil?
      end
    end
    false
  end

  def winning_diag?
    diagonals.each do |diag|
      diag.each_cons(WIN_CON) do |slice|
        return true if slice.uniq.length == 1 && !slice.uniq.first.nil?
      end
    end
    false
  end
end
