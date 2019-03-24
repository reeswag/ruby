class Engine 
    def initialize(scene_map)
      @scene_map = scene_map
    end
  
    def play(current_scene = nil)
      unless current_scene != nil
        current_scene = @scene_map.opening_scene() # Creates a current_scene by using the map start_scene paramenter as the key to access the @@scences Class.new value 
      else
        puts "automated user input:#{current_scene}"
      end

      until current_scene.is_a?(GameOver) || current_scene.is_a?(Credits)
        current_scene = @scene_map.scene_returner(current_scene.enter)
      end
      current_scene.enter # Calls enter on the end_game scene after the loop is broken-
    end
end

class Map
    $scenes = {'title' => Title.new(), 'start' => Start.new(), 'wall' => Wall.new(), 'fall' => Fall.new(), 'credits' => Credits.new, 'game_over' => GameOver.new}
    def initialize(start_scene)
      @start_scene = start_scene
    end
  
    def opening_scene() # Takes the initialised starting Map parameter and passes it to the scene_returner function. Alternatively @start_scene could be converted to a global variable $start_scene and manually used as a parameter in the Play engine function.
      scene_returner(@start_scene)
    end
    
    def scene_returner(scene_name) # Uses the scene_name parameter to return a new scene
      val = $scenes[scene_name]
      return val
    end  
end