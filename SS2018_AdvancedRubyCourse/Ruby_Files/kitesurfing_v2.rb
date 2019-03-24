$user_choices = []
$confidence = 0
$windy = false

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

    def wind
        flip = rand(2)
        if flip == 1
            $windy = true
            puts "\tIt's windy."
        else 
            $windy = false
            puts "\tIt's not windy."
        end
    end

    def game_over(reason)
        puts "\tGame Over...#{reason}"
        puts "\tYour choices were as follows:"
    
        if $user_choices.length == 1
            puts "\n\tDo you decide to go back to sleep?: #{$user_choices[0]}."
        else
            puts "\n\tDo you decide to go back to sleep?: #{$user_choices[0]} \n\tHow many drinks do you buy?: #{$user_choices[1]}."
        end
    
        puts "\n\tDo you want to play again? y/n"
        puts "\t> "
        user_choice_3 = $stdin.gets.chomp
    
        if user_choice_3 == "y"
            $confidence = 0
            $user_choices = []
            return 'home'
        elsif
            user_choice_3 == "n"
            exit
        else
            puts "\tI take it that's a no... fair enough"
            exit 
        end
    end
end

class Home < Scene
    def enter()
        puts "\tYou wake up in the morning, open the window and check the weather."
        wind
        puts "\tDo you decide to go back to sleep? y/n"
        puts "\t> "
        user_choice_1 = $stdin.gets.chomp
        $user_choices.push(user_choice_1)

        if user_choice_1 == "n"
            $confidence = 50
        elsif user_choice_1.downcase == "y"
            return 'sleep'
        else
            game_over("\tI really need a y/n from you... try again")
        end

        if $windy && $confidence >= 50 
            puts "\tSounds like you should go kiting then..."
            return 'kiting'
        elsif !$windy && $confidence >= 50 
            return 'bar'
        else
            "\texit home"
            exit(0)
        end
    end
end

class Bar < Scene
    def enter()
        while true
            puts "\tYou decide to head out to the local bar for a pick me up...\n\tHow many drinks do you buy?"
            puts "\t> "
            user_choice_2 = $stdin.gets.chomp
            $user_choices.push(user_choice_2)
            drinks = user_choice_2.to_i

            if drinks == 1
                puts "\t#{drinks} drink... OK then..."
            else
                puts "\t#{drinks} drinks... OK then..."
            end

            if drinks == 1 || 2 || 3 || 4 || 5 || 6 || 7 || 8 || 9
                $confidence = $confidence + (50 * drinks)
                puts "\tYou decide to head back to the flat, with a new feeling of self-confidence..."
                $windy = true
                puts "\tIt's now windy, let's go kiting!"
                return 'kiting'
            else
                game_over("maybe put a number next time...")
            end
        end
    end
end

class Sleep < Scene
    def enter()
        puts %Q{
        You decide to go to back to sleep.
        ........
        You wake up feeling fresh.
        You look out of the window and what do you see...
        }
        if $windy == true 
            puts "\tIt's still windy, lucky you!"
        else
            puts "\tWIND!!!!"
        end
        puts "\n\tLets go kiting!"
        $confidence = 50
        return 'kiting'
    end
end

class Kiting < Scene 
    def enter()
        puts "\n\tYou arrive at the beach. A scout is watching from Ozone.\n\tYou think back on the decisions you made today and jump into the water... "
        if $confidence == 100
            puts "\tYou are assured in your riding, confident in your decision making and perform to your optimum..."
            return 'credits'
        elsif $confidence < 100
            puts "\tYou ride timidly, lacking the confidence needed to impress..."
            game_over("you go back to your flat, exhausted. You close your eyes and a new day rolls in. I wonder if it'll be windy?")
        elsif $confidence > 100
            puts "\tYou ride overconfidently, crash and burn..."
            game_over("you feel a pain in your knee, you won't be kiting in a while...")
        else
            exit(2)
        end
    end
end

class Credits < Scene
    def enter()
      puts "\tThe sponsor walks over and offers you a professional contract, well done! \n\n\t\t...This was a REESWAG production..."
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
    @@scenes = {'home' => Home.new(), 'bar' => Bar.new(), 'sleep' => Sleep.new(), 'kiting' => Kiting.new(), 'credits' => Credits.new}
  
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

trial_map = Map.new('home')
trial_game = Engine.new(trial_map)
trial_game.play()
