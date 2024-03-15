# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/board'
require_relative '../lib/win_cons'
require_relative '../lib/player'
require_relative '../lib/game'

describe Game do
  subject(:std_game) { described_class.new }
  context 'when the game is started' do
    it 'cols has seven columns' do
      cols = 7
      expect(std_game.cols.size).to eq(cols)
    end
    it 'columns have six slots' do
      rows = 6
      expect(std_game.cols.size - 1).to eq(rows)
    end
    it 'has two players' do
      players = []
      players << std_game.player1
      players << std_game.player2
      num_players = players.compact.size
      expect(num_players).to eq(2)
    end
    it 'has no winner' do
      expect(std_game.winner).to be_nil
    end
  end

  subject(:logic_game) { described_class.new }
  let(:logic_player) { instance_double(Player) }
  context 'when a player takes a turn' do
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
    describe '#take_turn' do
      context 'when a turn is taken' do
        before do
          allow(logic_player).to receive(:input_move)
          allow(logic_game).to receive(:top_row).and_return(0)
        end
        it 'calls Player' do
          expect(logic_player).to receive(:input_move)
          logic_game.take_turn(logic_player)
        end
      end
      let(:valid_move) { 0 }
      context 'when a valid input is returned by input_move' do
        before do
          allow(logic_player).to receive(:input_move).and_return(valid_move)
          allow(logic_player).to receive(:token).and_return('test')
        end
        it 'changes @cols to the correct token' do
          i = valid_move
          expect { logic_game.take_turn(logic_player) }.to change { logic_game.cols[i][0] }.to('test')
        end
      end
    end
  end
  describe '#full?' do
    subject(:full_game) do
      described_class.new(Array.new(7) { Array.new(6, 'x') })
    end
    context 'when cols are all occupied by truthy elements' do
      it 'game is full' do
        expect(full_game).to be_full
      end
    end
    context 'when a column is passed as an arg' do
      it 'column is full' do
        some_col = 4
        expect(full_game.full?(some_col)).to be true
      end
    end
    context 'when an invalid col is passed' do
      it 'column is full' do
        out_of_bounds = 100
        expect(full_game.full?(out_of_bounds)).to be true
      end
    end
  end
  describe '#play' do
    subject(:play_game) { described_class.new }
    context 'when the game is over' do
      context '...because there is a winner' do
        it 'ends the game' do
          allow(play_game).to receive(:take_turns).and_return(play_game.winner = true)
          expect(play_game.play).to be_nil
        end
      end
      context '...because the board is full' do
        it 'ends the game' do
          allow(play_game).to receive(:full?).and_return(true)
          expect(play_game.play).to be_nil
        end
      end
    end
  end
  describe '#take_turns' do
    subject(:turns_game) { described_class.new }
    context 'when turns are taken' do
      it 'both players take turns' do
        allow_any_instance_of(Game).to receive(:take_turn).and_return(nil)
        expect(turns_game).to receive(:take_turn).twice
        turns_game.take_turns
      end
    end
  end
  describe '#winning_col?' do
    context 'when there is no winning column' do
      subject(:non_winning_col_game) { described_class.new }

      it 'returns false' do
        expect(non_winning_col_game.winning_col?).to be false
      end
    end

    context 'when there is a winning column' do
      subject(:winning_col_game) { described_class.new }

      it 'returns true' do
        winning_col = 3
        winning_token = 'X'
        winning_col_game.cols[winning_col] = [winning_token] * 4
        expect(winning_col_game.winning_col?).to be true
      end
    end
  end
  describe '#winning_row?' do
    context 'when there is no winning row' do
      subject(:non_winning_row_game) { described_class.new }

      it 'returns false' do
        expect(non_winning_row_game.winning_row?).to be false
      end
    end

    context 'when there is a winning row' do
      subject(:winning_row_game) { described_class.new }

      it 'returns true' do
        winning_row = 0
        winning_token = 'X'
        winning_row_game.cols[0..4].each { |col| col[0] = winning_token }
        expect(winning_row_game.winning_row?).to be true
      end
    end
  end
  describe '#winning_diag?' do
    context 'when there is no winning diagonal' do
      subject(:non_winning_diag_game) { described_class.new }

      it 'returns false' do
        expect(non_winning_diag_game.winning_diag?).to be false
      end
    end
    context 'when there is a winning diagonal' do
      subject(:winning_diag_game) { described_class.new }

      it 'returns true' do
        winning_token = 'X'
        winning_diag_game.cols[0][0] = winning_token
        winning_diag_game.cols[1][1] = winning_token
        winning_diag_game.cols[2][2] = winning_token
        winning_diag_game.cols[3][3] = winning_token
        expect(winning_diag_game.winning_diag?).to be true
      end
    end
  end
end
