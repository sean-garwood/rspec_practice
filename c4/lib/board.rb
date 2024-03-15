# frozen_string_literal: true

# connect four board
module Board
  NUM_COLS = 7
  NUM_ROWS = 6
  EMPTY_BOARD = Array.new(NUM_COLS) { Array.new(NUM_ROWS) { nil } }
  def top_row(col)
    cols[col].any? ? cols[col].compact.size : 0
  end

  def diagonals
    (0..NUM_COLS - 1).each_with_object([]) do |col, diags|
      diags << (0..NUM_ROWS - 1).each_with_object([]) do |row, diag|
        diag << cols[col + row][row] if (col + row).between?(0, NUM_COLS - 1)
      end
    end
  end

  def rows
    cols.each_with_object([]) do |col, rows|
      col.each_with_index do |cell, row|
        rows[row] ||= []
        rows[row] << cell
      end
    end
  end

  def full?(column = nil)
    return cols.all?(&:all?) unless column
    return true if column > NUM_COLS || column.negative?

    cols[column].all?
  end

  def print_board
    puts ' 0 1 2 3 4 5 6'
    NUM_ROWS.times do |row|
      print '|'
      NUM_COLS.times do |col|
        print "#{cols[col][NUM_ROWS - row - 1] || ' '}|"
      end
      puts
    end
  end
end
