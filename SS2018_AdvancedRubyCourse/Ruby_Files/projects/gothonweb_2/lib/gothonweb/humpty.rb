module Map
    class Room 

        def initialize(name, description)
            @name = name
            @description = description
            @paths = {}
        end

        attr_reader :name
        attr_reader :paths
        attr_reader :description

        def go(direction)
            return @paths[direction]
        end

        def add_paths(paths)
            @paths.update(paths) #.update adds one hash to another
        end
        
    end

    TITLE = Room.new("Title",
        """
        Colchester, the 15th century.Meet Humpty Dumpty, an ordinary walking, talking egg. Can you help Humpty become the stuff of legends?
        Make the right choices and, with a bit of luck, children will be talking about him for centuries...
        Press enter to start Humpty's Tale...
        """)

    INTRO = Room.new("Intro",
        """
        Should Humpty Dumpty sit on the wall?
        """)

    WALL = Room.new("Wall",
        """
        Has Humpty been drinking?
        """)

    FALL = Room.new("Fall",
        """
        All the king's horses and all the king's men
        """)

    THE_END_WINNER = Room.new("The End",
        """
        Chicken Dinner
        """)

    GENERIC_ENDING = Room.new("The End",
        """
        Game Over...
        """)

    TITLE.add_paths({
        'Enter'=> INTRO,
        'End Game' => GENERIC_ENDING
    })

    INTRO.add_paths({
        'Sit'=> WALL,
        'Go Home' => GENERIC_ENDING
    })

    WALL.add_paths({
        'He has had a few...' => FALL,
        'Sober as a nun' => GENERIC_ENDING
    })

    FALL.add_paths({
        'Heads'=> THE_END_WINNER,
        'Tails' => GENERIC_ENDING
    })

    START = TITLE

    ROOM_NAMES = {
        'TITLE' => TITLE,
        'INTRO' => INTRO,
        'WALL' => WALL,
        'FALL' => FALL,
        'THE_END_WINNER' => THE_END_WINNER,
        'GENERIC_ENDING' => GENERIC_ENDING,
        'START' => START
    }

    def Map::load_room(session) # Given a session this will return the right room or nil
        return ROOM_NAMES[session[:room]]
    end

    def Map::save_room(session, room) # Store the room in the session for later, using its name
        session[:room] = ROOM_NAMES.key(room)
    end
end


=begin
    
    def enter(title_prompt = nil)
        puts "\nColchester, the 15th century.\nMeet Humpty Dumpty, an ordinary walking, talking egg.\nCan you help Humpty become the stuff of legends?\nMake the right choices and, with a bit of luck, children will be talking about him for centuries..."
        puts "\nPress any key to start Humpty's Tale..."

        unless title_prompt != nil
            STDIN.gets.chomp
        else
            return 'start'
        end
        return 'start'
    end
end

class Start < Scene
    def enter(user_choice_1 = nil)
        puts "Should Humpty Dumpty sit on the wall?"
        puts "y/n ->"

        unless user_choice_1 != nil
            user_choice_1 = STDIN.gets.chomp
        else
            puts "automated user input:#{user_choice_1}"
        end

        if user_choice_1 =="y"
            puts "\n\tHumpty Dumpty sat on a wall,"
            $outcome_log.push("Humpty Dumpty sat on a wall,")
            return 'wall'
        else 
            $game_over_reason = "Better luck next time..."
            return 'game_over'
        end
    end
end

class Wall < Scene
    def enter(user_choice_2 = nil)
        puts "\nHas Humpty been drinking???"
        puts "y/n ->"

        unless user_choice_2 != nil
            user_choice_2 = STDIN.gets.chomp 
        else
            puts "automated user input:#{user_choice_2}"
        end

        if user_choice_2 =="y" 
            puts "\n\tHumpty Dumpty had a great fall;"
            $outcome_log.push("Humpty Dumpty had a great fall;")
            return 'fall'
        elsif  user_choice_2 =="n" 
            puts "\n\tHumpty Dumpty had a great time sitting on the wall!"
            $outcome_log.push("Humpty Dumpty had a great time sitting on the wall!")
            $game_over_reason = "Hmm, something about the rhyme wasn't quite right..."
            return 'game_over'
        else
            $game_over_reason = "Try again...this time with a y/n..."
            return 'game_over'
        end
        
    end
end

class Fall < Scene
    def enter(r_h_t = 'random', user_choice_3 = nil )
        puts "\n\tAll the king's horses and all the king's men"
        $outcome_log.push("All the king's horses and all the king's men")
        puts "Flip Coin?"
        puts "y/n ->"

        unless user_choice_3 != nil
            user_choice_3 = STDIN.gets.chomp 
        else
            puts "automated user input:#{user_choice_3}"
        end

        if user_choice_3 == "y" 
            coin_toss(r_h_t)
        elsif user_choice_3 == "n"
            puts "\n\tCould put Humpty together again."
            $outcome_log.push("Could put Humpty together again.")
            $game_over_reason = "sometimes fortune favours the brave..."
            return 'game_over'
        else
            $game_over_reason = "Try again...this time with a y/n..."
            return 'game_over'
        end

        if @@result == "Heads!"
            puts "\n\tCouldn't put Humpty together again."
            $outcome_log.push("Couldn't put Humpty together again.")
            return 'credits'
        elsif @@result == "Tails!"
            puts "\n\tCould put Humpty together again."
            $outcome_log.push("Could put Humpty together again.")
            $game_over_reason = "sometimes luck isn't on your side..."
            return 'game_over'
        else
            puts "this should never be seen"
            exit(2)
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
    end
end



class GameOver < Scene
    def enter()
        puts "\n\tGame Over...#{$game_over_reason}"
    end
end




$outcome_log = []

class Scene  
    def enter()
      puts "Default Text"
    end

    def coin_toss(ct_output = nil)
        puts "Flipping a coin..."

        if ct_output == 'random'
            $flip = rand(2)
        elsif ct_output == 'Heads!'
            puts "automated user input:#{ct_output}"
            $flip = 1
        elsif ct_output == 'Tails!'
            puts "automated user input:#{ct_output}"
            $flip = 0
        else
            puts "automated user input:#{ct_output}"
            puts "Input not recognised, defaulted to random"
        end
                
        if $flip == 1
            @@result = "Heads!"
        else 
            @@result = "Tails!"
        end

        puts "#{@@result}"
        return @@result        
    end   
end

class Title < Scene
    def enter(title_prompt = nil)
        puts "\nColchester, the 15th century.\nMeet Humpty Dumpty, an ordinary walking, talking egg.\nCan you help Humpty become the stuff of legends?\nMake the right choices and, with a bit of luck, children will be talking about him for centuries..."
        puts "\nPress any key to start Humpty's Tale..."

        unless title_prompt != nil
            STDIN.gets.chomp
        else
            return 'start'
        end
        return 'start'
    end
end

class Start < Scene
    def enter(user_choice_1 = nil)
        puts "Should Humpty Dumpty sit on the wall?"
        puts "y/n ->"

        unless user_choice_1 != nil
            user_choice_1 = STDIN.gets.chomp
        else
            puts "automated user input:#{user_choice_1}"
        end

        if user_choice_1 =="y"
            puts "\n\tHumpty Dumpty sat on a wall,"
            $outcome_log.push("Humpty Dumpty sat on a wall,")
            return 'wall'
        else 
            $game_over_reason = "Better luck next time..."
            return 'game_over'
        end
    end
end

class Wall < Scene
    def enter(user_choice_2 = nil)
        puts "\nHas Humpty been drinking???"
        puts "y/n ->"

        unless user_choice_2 != nil
            user_choice_2 = STDIN.gets.chomp 
        else
            puts "automated user input:#{user_choice_2}"
        end

        if user_choice_2 =="y" 
            puts "\n\tHumpty Dumpty had a great fall;"
            $outcome_log.push("Humpty Dumpty had a great fall;")
            return 'fall'
        elsif  user_choice_2 =="n" 
            puts "\n\tHumpty Dumpty had a great time sitting on the wall!"
            $outcome_log.push("Humpty Dumpty had a great time sitting on the wall!")
            $game_over_reason = "Hmm, something about the rhyme wasn't quite right..."
            return 'game_over'
        else
            $game_over_reason = "Try again...this time with a y/n..."
            return 'game_over'
        end
        
    end
end

class Fall < Scene
    def enter(r_h_t = 'random', user_choice_3 = nil )
        puts "\n\tAll the king's horses and all the king's men"
        $outcome_log.push("All the king's horses and all the king's men")
        puts "Flip Coin?"
        puts "y/n ->"

        unless user_choice_3 != nil
            user_choice_3 = STDIN.gets.chomp 
        else
            puts "automated user input:#{user_choice_3}"
        end

        if user_choice_3 == "y" 
            coin_toss(r_h_t)
        elsif user_choice_3 == "n"
            puts "\n\tCould put Humpty together again."
            $outcome_log.push("Could put Humpty together again.")
            $game_over_reason = "sometimes fortune favours the brave..."
            return 'game_over'
        else
            $game_over_reason = "Try again...this time with a y/n..."
            return 'game_over'
        end

        if @@result == "Heads!"
            puts "\n\tCouldn't put Humpty together again."
            $outcome_log.push("Couldn't put Humpty together again.")
            return 'credits'
        elsif @@result == "Tails!"
            puts "\n\tCould put Humpty together again."
            $outcome_log.push("Could put Humpty together again.")
            $game_over_reason = "sometimes luck isn't on your side..."
            return 'game_over'
        else
            puts "this should never be seen"
            exit(2)
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
    end
end

class GameOver < Scene
    def enter()
        puts "\n\tGame Over...#{$game_over_reason}"
    end
end

=end