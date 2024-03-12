# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  let(:std_cols) { described_class::NUM_COLS }
  let(:std_rows) { described_class::NUM_ROWS }
  let(:player_a) { instance_double(Player, name: 'a') }
  let(:player_b) { instance_double(Player, name: 'b') }
  subject(:std_game) { described_class.new(player_a) }
  context 'when the board is standard size' do
    it 'has seven columns' do
      cols = std_cols
      expect(std_game.cols.size).to eq(cols)
    end
    it 'columns have six slots' do
      rows = std_cols - 1
      expect(std_game.cols.size - 1).to eq(rows)
    end
    it 'has two players' do
      players = []
      players << std_game.player_one
      players << std_game.player_two
      num_players = players.compact.size
      expect(num_players).to eq(2)
    end
    it 'has no winner' do
      expect(std_game.winner).to be_nil
    end
  end

  subject(:logic_game) { described_class.new }
  describe '#legal?' do
    it 'declares out-of-bounds moves illegal' do
      move = 10
      expect(std_game.legal?(move)).to be false
    end
    it 'declares negative moves illegal' do
      move = -1
      expect(std_game.legal?(move)).to be false
    end
    it 'declares valid moves legal' do
      move = 1
      expect(std_game.legal?(move)).to be true
    end
  end
end
