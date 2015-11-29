require_relative "lib/game"
require "yaml"

response = ''
until response == '1' || response == '2'
  puts "Select an option:"
  puts "1) New game"
  puts "2) Load last saved game"
  print "(1/2): "
  response = gets.chomp
end

case response
when '1'
  Game.new.start
when '2'
  YAML.load(File.read(Game.savefile)).play
end
