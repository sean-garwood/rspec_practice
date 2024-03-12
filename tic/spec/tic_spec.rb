# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/win_cons'

# types
# 1. Command - Changes the observable state, but does not return a value.
# 2. Query - Returns a result, but does not change the observable state.
# 3. Script - Only calls other methods, usually without returning anything.
# 4. Looping Script - Only calls other methods, usually without returning
#    anything, and stops when certain conditions are met.
# always test
# 1. Public Command or Public Query Methods should always be tested, because
# they are the public interface. Command Methods should test the method's action
# or side effect. Query Methods should test the method's return value.
# 2. Command or Query Methods that are inside a public script or looping script
# method should be tested. For the games that we are making, script and looping
# script methods are just a convenient way to call the methods needed to play a
# full game. Since these methods are required to play the game, they should be
# tested and made public (even if you previously made them private). Pretend
# that someone will be using your class to make their own game with customized
# text. Any method that they would need in their game should be part of the
# public interface and have test coverage.
# 3. Any method that sends a command message to another class should always test
# that those messages were sent.
# 4. A Looping Script Method should test the behavior of the method. For
# example, that it stops when certain conditions are met.
# don't test:
# 1. You do not have to test #initialize if it is only creating instance
# variables. However, if you call methods inside the initialize method, you
# might need to test #initialize and/or the inside methods. In addition, you
# will need to stub any inside methods because they will be called when you
# create an instance of the class.
# 2. You do not have to test methods that only contain 'puts' or 'gets'
# because they are well-tested in the standard Ruby library.
# 3. Private methods do not need to be tested because they should have test
# coverage in public methods. However, as previously discussed, you may have
# some private methods that are called inside a script or looping script method;
# these methods should be tested publicly.
# summary
# 1. Command Method -> Test the change in the observable state
# 2. Query Method -> Test the return value
# 3. Method with Outgoing Command -> Test that a message is sent
# 4. Looping Script Method -> Test the behavior of the method

describe Game do
  let(:p1) { instance_double(Player, name: 'player 1') }
  let(:p2) { instance_double(Player, name: 'player 2') }
  let(:x) { 1 }
  let(:o) { -1 }
  let(:blank) { 0 }
  let(:win_con) { WinConditions::WIN_CON }
  shared_examples 'a full board' do
    describe '#full?' do
      it 'is full' do
        expect(game).to be_full
      end
    end
    describe '#winning_row?' do
      it 'is a winning row' do
        expect(game).to be_winning_row
      end
    end
    describe '#winning_column?' do
      it 'is a winning column' do
        expect(game).to be_winning_column
      end
    end
    describe '#sum_diagonals' do
      it 'equals [4, 4]' do
        expect(game.sum_diagonals).to eq([4, 4])
      end
    end
    describe '#winning_diagonal?' do
      it 'is a winning diagonal' do
        expect(game).to be_winning_diagonal
      end
    end
    describe '#over?' do
      it 'is over' do
        expect(game).to be_over
      end
    end
    describe '#cats_game?' do
      it 'is not a tie' do
        expect(game).not_to be_cats_game
      end
    end
    describe '#declare_winner' do
      it 'modifies the winner' do
        winning_player = 'sean'
        expect do
          game.declare_winner(winning_player)
        end.to change { game.winner }.from(nil).to(winning_player)
      end
    end
    describe '#bump_turn_number' do
      it 'increases turn number by 1' do
        expect { game.bump_turn_number }.to change { game.turn_number }.from(1).to(2)
      end
    end
    describe '#mark_square' do
      it 'does not change the top-left square' do
        row = 0
        col = 0
        letter = 'z'
        expect do
          game.mark_square(row, col, letter)
        end.not_to(change { game.board[0][0] })
      end
    end
  end

  context 'when the board is full of Xs' do
    let(:all_x_board) { Array.new(win_con) { Array.new(win_con, x) } }
    subject(:game) { described_class.new(p1, p2, all_x_board) }
    it_behaves_like 'a full board'
  end

  context 'when the board is full of Os' do
    let(:all_o_board) { Array.new(win_con) { Array.new(win_con, o) } }
    subject(:game) { described_class.new(p1, p2, all_o_board) }
    it_behaves_like 'a full board'
  end

  context 'when the board is empty' do
    let(:empty_board) { Array.new(win_con) { Array.new(win_con, blank) } }
    subject(:game) { described_class.new(p1, p2, empty_board) }
    describe '#mark_square' do
      it 'changes the top-left square from blank to something' do
        row = 0
        col = 0
        letter = x
        expect do
          game.mark_square(row, col, letter)
        end.to change { game.board[0][0] }.from(0).to(1)
      end
    end
    describe '#full?' do
      it 'is not full' do
        expect(game).not_to be_full
      end
    end
    describe '#won?' do
      it 'is no winner' do
        expect(game).not_to be_won
      end
    end
  end
end
describe Player do
  subject(:player_one) { described_class.new }
  context 'when players is odd' do
    describe '#player_letter' do
      it 'is one' do
        expect(player_one.letter).to eq(1)
      end
    end
  end
  subject(:player_two) { described_class.new }
  context 'when players is even' do
    describe '#player_letter' do
      it 'is neg one' do
        expect(player_two.letter).to eq(-1)
      end
    end
  end
end
