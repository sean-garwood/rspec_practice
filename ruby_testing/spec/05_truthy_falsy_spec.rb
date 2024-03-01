# frozen_string_literal: true

# Do not use 'be_truthy' or 'be_falsy' for methods that should only be
# evaluated into a Boolean.
# https://luten.dev/rspec-be_truthy-exists-or-be-true/

describe 'truthy and falsy' do
  context 'almost everything is truthy' do
    it 'strings are truthy' do
      expect('foo').to be_truthy
    end

    it 'zero is truthy' do
      expect(0).to be_truthy
    end

    it 'floats are truthy' do
      expect(3.14159).to be_truthy
    end

    it 'arrs are truthy' do
      expect([]).to be_truthy
    end

    it 'hashes are truthy' do
      expect({}).to be_truthy
    end

    it 'symbols are truthy' do
      expect(:any_symbol).to be_truthy
    end

    it 'true is truly truthy' do
      expect(true).to be_truthy
      # one should hope so
    end
  end

  context 'except for' do
    it 'false is falsy' do
      expect(false).to be_falsy
    end

    it 'nil is falsy' do
      expect(nil).to be_falsy
    end
  end
end
