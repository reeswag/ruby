require "./humpty/scene_v3.rb"
require "./humpty/engine_map_v2.rb"

trial_map = Map.new('title')
trial_game = Engine.new(trial_map)
trial_game.play()