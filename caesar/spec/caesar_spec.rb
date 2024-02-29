# frozen_string_literal: true

require './lib/caesar'

describe Cipher do
  caesar = Cipher.new
  describe '#offset' do
    it 'returns index of capital letter in CAPS' do
      expect(caesar.offset('A')).to eql(0)
    end
    it 'returns index of lowercase letter in DOWN' do
      expect(caesar.offset('z')).to eql(25)
    end
  end
<<<<<<< HEAD
=======

  describe '#shift' do
    it 'returns the correct lowercase letter' do
      expect(caesar.shift('a', 0)).to eql('a')
    end

    it 'returns the correct capital letter' do
      expect(caesar.shift('Z', 25)).to eql('Z')
    end
  end

  describe '#cipher' do
    it 'shifts the lowercase letter' do
      expect(caesar.cipher('a', 1)).to eql('b')
    end

    it 'wraps the uppercase letter' do
      expect(caesar.cipher('Z', 1)).to eql('A')
    end
  end
>>>>>>> 8b92b14 (Test/validate Cipher)
end
