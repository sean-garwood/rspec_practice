# frozen_string_literal: true

# connect four players
class Player
  TOKENS = {
    black_square: "\u25A0",
    white_square: "\u25A1"
  }.freeze
  attr_reader :name, :token

  def initialize(name = 'p1', token = :white_square)
    @name = name
    @token = assign_token(token)
  end

  def assign_token(token)
    TOKENS[token]
  end

  def input_move
    input = nil
    loop do
      input = verify_input(prompt_input)
      break if input

      puts 'Invalid input. Please try again.'
    end
    input
  end

  def verify_input(number)
    number.to_i if number =~ /^[0-6]$/
  end

  private

  def prompt_input
    puts 'Enter a column number (0-6):'
    gets.chomp
  end
end
