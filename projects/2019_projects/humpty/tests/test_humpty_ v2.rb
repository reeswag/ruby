require "./lib/humpty/scene_v3.rb"
require "./lib/humpty/engine_map_v3.rb"
require "test/unit"

class TestHumpty < Test::Unit::TestCase

  @@title = Title.new()
  @@start = Start.new()
  @@wall = Wall.new()
  @@fall = Fall.new()
  @@coin_test = Scene.new()
  @@test_map = Map.new('title')
  @@test_game = Engine.new(@@test_map)
  @@test_array = Array.new 

  def test_coin_toss()
    sum = 0
    10.times do
      @@coin_test.coin_toss('random')
      puts $flip
      sum = sum + $flip
    end
    assert_not_equal(sum, 0)
    assert_not_equal(sum, 10)
  end

  def test_winning_combination()
    paths = [@@title.enter('gg'), @@start.enter("y"), @@wall.enter("y"), @@fall.enter('Heads!',"y")]
    test_paths = ['start', 'wall', 'fall', 'credits']
    puts "paths: #{paths}"
    puts
    puts "expected paths: #{test_paths}"
    assert_equal(paths, test_paths) # This test only works when the user inputs the correct answers and the coin flip is successfull. A better option would be to create a hash with all possible user inputs and check the output is as expected. If the user makes the wrong choice the program exits and never reaches the assertion section.
  end

  def test_losing_user_choice()
    paths = [@@start.enter("n"), @@wall.enter("n"), @@fall.enter('Heads!',"n")]
    test_paths = ['game_over', 'game_over', 'game_over']
    puts "paths: #{paths}"
    puts
    puts "expected paths: #{test_paths}"
    assert_equal(paths, test_paths) # This test only works when the user inputs the correct answers and the coin flip is successfull. A better option would be to create a hash with all possible user inputs and check the output is as expected. If the user makes the wrong choice the program exits and never reaches the assertion section.
  end

  def test_losing_coin_flip()
    paths = @@fall.enter('Tails!', "y")
    test_paths = 'game_over'
    puts "paths: #{paths}"
    puts
    puts "expected paths: #{test_paths}"
    assert_equal(paths, test_paths) # This test only works when the user inputs the correct answers and the coin flip is successfull. A better option would be to create a hash with all possible user inputs and check the output is as expected. If the user makes the wrong choice the program exits and never reaches the assertion section.
  end

  def test_map_methods()
    assert_respond_to(@@test_map, :opening_scene)
    assert_respond_to(@@test_map, :scene_returner)
  end

  def test_scene_returner()
    
    $scenes.each do |x, y| 
     @@test_array << @@test_map.scene_returner(x)
    end

    @count = 0 
    @@test_array.each do |x|
      expected = [Title, Start, Wall, Fall, Credits, GameOver]
      puts x
      assert_kind_of(expected[@count], x)
      @count += 1
    end
  end 

  def test_opening_scene()
    assert_equal(@@test_map.opening_scene(), @@test_map.scene_returner('title'))
  end
end
    