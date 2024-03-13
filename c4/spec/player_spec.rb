# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  subject(:p1) { described_class.new }
  context 'when a new player is created without params' do
    it 'is assigned the name p1' do
      expect(p1.name).to eq('p1')
    end
    it 'is assigned a white square token by default' do
      expect(p1.token).to eq("\u25A1")
    end
  end

  subject(:p2) { described_class.new('p2', :black_square) }
  context 'when a new player is created with params p2 and black_square' do
    it 'is assigned the correct name' do
      expect(p2.name).to eq('p2')
    end
    it 'is assigned the correct token' do
      expect(p2.token).to eq("\u25A0")
    end
  end

  describe '#verify_input' do
    subject(:input_player) { described_class.new }
    context 'when given a valid input' do
      it 'returns valid input' do
        user_input = '4'
        verified = input_player.verify_input(user_input)
        expect(verified).to eq(4)
      end
    end
    context 'when given an invalid input' do
      it 'returns nil' do
        user_input = '-100'
        verified = input_player.verify_input(user_input)
        expect(verified).to be_nil
      end
    end
  end

  describe '#input_move' do
    subject(:player_move) { described_class.new }
    let(:err_msg) { 'Invalid input. Please try again.' }
    let(:invalid) { '-1' }
    let(:prompt) { 'Enter a column number (0-6):' }
    let(:valid) { '1' }
    context 'when given valid input' do
      before do
        allow(player_move).to receive(:gets).and_return(valid)
      end
      it 'breaks and does not return err msg' do
        expect(player_move).not_to receive(:puts).with(err_msg)
        player_move.input_move
      end
      it 'returns a number' do
        expect(player_move.input_move).to eq(valid.to_i)
      end
    end
    context 'when given an invalid input and then a valid input' do
      it 'returns the error message' do
        allow(player_move).to receive(:prompt_input).and_return(invalid, valid)
        expect(player_move).to receive(:puts).with(err_msg).once
        player_move.input_move
      end
    end
  end
end
