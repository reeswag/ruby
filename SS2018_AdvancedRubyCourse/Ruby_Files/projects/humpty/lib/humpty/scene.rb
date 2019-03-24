class Scene
    def enter()
      puts "Default Text"
    end

    def coin_toss()
        puts "Flipping a coin..."

        unless defined? $flip
            $flip = rand(2)
        else
            puts "automated user input:#{$flip}"
        end
                
        if $flip == 1
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

        unless defined? $title_prompt
            STDIN.gets.chomp
        else
            return 'start'
        end

        return 'start'
    end
end

class Start < Scene
    def enter()
        puts "Should Humpty Dumpty sit on the wall?"
        puts "y/n ->"

        unless defined? $user_choice_1
            $user_choice_1 = STDIN.gets.chomp
        else
            puts "automated user input:#{$user_choice_1}"
        end

        if $user_choice_1 =="y"
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

        unless defined? $user_choice_2
            $user_choice_2 = STDIN.gets.chomp 
        else
            puts "automated user input:#{$user_choice_2}"
        end

        if $user_choice_2 =="y" 
            puts "\n\tHumpty Dumpty had a great fall;"
            return 'fall'
        elsif  $user_choice_2 =="n" 
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

        unless defined? $user_choice_3
            $user_choice_3 = STDIN.gets.chomp 
        else
            puts "automated user input:#{$user_choice_3}"
        end

        if $user_choice_3 =="y" && coin_toss() == "Heads!"
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