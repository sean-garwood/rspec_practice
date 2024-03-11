# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/player'

player_one = Player.new
player_two = Player.new('2')
game = Game.new(player_one, player_two)
puts "Game on! Good luck, players.\n"

until game.over?
  game.take_turn(player_one)
  game.take_turn(player_two)
end
