class Engine 
    def initialize(scene_map)
      @scene_map = scene_map
    end
  
    def play()
      current_scene = @scene_map.opening_scene() # Creates a current_scene by using the map start_scene paramenter as the key to access the @@scences Class.new value 
      while !current_scene.is_a? Credits # Creates a loop until the final scene in the heirarchy is reached
        current_scene = @scene_map.scene_returner(current_scene.enter) # Calls enter on the current_scene, re-assigns the current-scene based on the returned 'scene key' and loops
      end
      current_scene.enter # Calls enter on the Credits scene after the loop is broken
    end
end

class Scene
    def enter()
      puts "Default Text"
    end

    def coin_toss()
        puts "Flipping a coin..."
        flip = rand(2)
        
        if flip == 1
            @@result = "Heads!"
        else 
            @@result = "Tails!"
        end

        puts "#{@@result}"
        return @@result        
    end

    def game_over(reason)
        puts "Game Over...#{reason}"
        exit(0)
    end
       
end

class Title < Scene
    def enter()
        puts "\nColchester, the 15th century.\nMeet Humpty Dumpty, an ordinary walking, talking egg.\nCan you help Humpty become the stuff of legends?\nMake the right choices and, with a bit of luck, children will be talking about him for centuries..."
        puts "\nPress any key to start Humpty's Tale..."
        STDIN.gets.chomp
        return 'start'
    end
end

class Start < Scene
    def enter()
        puts "Should Humpty Dumpty sit on the wall?"
        puts "y/n ->"
        user_choice_1 = STDIN.gets.chomp

        if user_choice_1 =="y"
            puts "\n\tHumpty Dumpty sat on a wall,"
            return 'wall'
        else 
            game_over("Better luck next time...")
        end
    end
end

class Wall < Scene
    def enter()
        puts "\nHas Humpty been drinking???"
        puts "y/n ->"
        user_choice_2 = STDIN.gets.chomp 

        if user_choice_2 =="y" 
            puts "\n\tHumpty Dumpty had a great fall;"
            return 'fall'
        elsif  user_choice_2 =="n" 
            puts "\n\tHumpty Dumpty had a great time sitting on the wall!"
            game_over("Hmm, something about the rhyme wasn't quite right...")
        else
            game_over("Try again...this time with a y/n...")
        end
        
    end
end

class Fall < Scene
    def enter()
        puts "\n\tAll the king's horses and all the king's men"
        puts "Flip Coin?"
        puts "y/n ->"
        user_choice_3 = STDIN.gets.chomp 

        if user_choice_3 =="y" && coin_toss() == "Heads!"
            puts "\n\tCouldn't put Humpty together again."
            return 'credits'
        elsif @@result == "Tails!"
            puts "\n\tCould put Humpty together again."
            game_over("sometimes luck isn't on your side...")
        else
            game_over("Try again...this time with a y/n...")
        end
    end
end

class Credits < Scene
    def enter()
        puts "\n\t\t...This was a REESWAG production..."
        puts %Q{
            .                                            .              
            *   .                  .              .        .   *          .        
         .         .                     .       .           .      .        .     
               o                             .                   .                 
                .              .                  .           .                    
                 0     .                                                           
                        .          .                 ,                ,    ,       
        .          \\          .                         .                          
             .      \\   ,                                                          
          .          o     .                 .                   .            .    
            .         \                 ,             .                .           
                      #\\##\\#      .                              .        .        
                    #  #O##\###                .                        .          
          .        #*#  #\\##\###                       .                     ,     
               .   ##*#  #\##\##               .                     .             
             .      ##*#  #o##\#         .                             ,       .   
                 .     *#  #\#     .                    .             .          , 
                             \          .                         .                
       ____^/\\___^--____/\\____O______________/\\/\\---/\\___________---______________ 
          /\\^   ^  ^    ^                  ^^ ^  '\\ ^          ^       ---         
                --           -            --  -      -         ---  __       ^     
          --  __                      ___--  ^  ^                         --  __ 
            }
          game_over("...")
    end
end

class Map
    @@scenes = {'title' => Title.new(), 'start' => Start.new(), 'wall' => Wall.new(), 'fall' => Fall.new(), 'credits' => Credits.new}
  
    def initialize(start_scene)
      @start_scene = start_scene
    end
  
    def opening_scene() # Takes the initialised starting Map parameter and passes it to the scene_returner function. Alternatively @start_scene could be converted to a global variable $start_scene and manually used as a parameter in the Play engine function.
      scene_returner(@start_scene)
    end
    
    def scene_returner(scene_name) # Uses the scene_name parameter to return a new scene
      val = @@scenes[scene_name]
      return val
    end  
end

trial_map = Map.new('title')
trial_game = Engine.new(trial_map)
var = 'car'
trial_map.enter()
#trial_game.play()
