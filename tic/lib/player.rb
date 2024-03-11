# frozen_string_literal: true

# Represents state of each player. Initializes two Player objs/game
class Player
  attr_reader :letter, :name

  @@players = 1

  def initialize(name = '1')
    @name = name
    @letter = player_letter
    @@players += 1
  end

  def player_turn
    turn_number.odd? ? player_one.name : player_two.name
  end

  def player_letter
    @@players.odd? ? 1 : -1
  end

  def to_s
    name
  end
end
