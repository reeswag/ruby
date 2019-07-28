=begin

Scenario Branches.
1. home = Wake up in the morning, check weather. - Starting confidence = 0.
    a. Windy? + feel good - confidence = 50
        i.Go kiting.
            - KITING Arrive at beach, what size kite?
                - 12, 10, 8.
                    A sponsor is watching from the beach. Final result = Kitesize * courage.
                        if result = 200
                            win
                        if result > 200  
                            die
                        if result < 200 
                            No one cares.


                    - Too much power, die
                        - Game over
                - 10 
                    - Perfect 
                        - Win game
                - 8
                    - Too little power, no fun.
                        - Game over. 
        ii. Windy/not windy/confidence = 0
                    confidence = 0 - go back to sleep - start
                            
                            
    b. - while loop to return to the start
        i. If Go back to sleep
            ii.  
                - Go to KITING
            ii. Get a beer. - each beer doubles confidence level. - it is now windy - Go to KITING.
        

=end

$user_choices = []

def wind
    flip = rand(2)
    if flip == 1
        $windy = true
        puts "\tIt's windy."
        home
    else 
        $windy = false
        puts "\tIt's not windy."
        home
    end
end

def home
    puts "\tDo you decide to go back to sleep? y/n"
    puts "\t> "
    user_choice_1 = $stdin.gets.chomp
    $user_choices.push(user_choice_1)

    if user_choice_1 == "n"
        $confidence = 50
    elsif user_choice_1.downcase == "y"
        sleep
    else
        game_over("\tI really need a y/n from you... try again")
    end

    if $windy && $confidence >= 50 
        kiting
    elsif !$windy && $confidence >= 50 
        bar
    else
        "\texit home"
        exit(0)
    end
end

def bar
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
            kiting
        else
            game_over
        end
    end
end

def sleep
    puts %q{
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
    kiting
end

def kiting
    puts "\n\tYou arrive at the beach. A scout is watching from Ozone.\n\tYou think back on the decisions you made today and jump into the water... "
    if $confidence == 100
        puts "\tYou are assured in your riding, confident in your decision making and perform to your optimum..."
        game_over("the sponsor walks over and offers you a professional contract, well done!")
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
        wind
    elsif
        user_choice_3 == "n"
        exit
    else
        puts "\tI take it that's a no... fair enough"
        exit 
    end

end

puts "\tYou wake up in the morning, open the window and check the weather."
$confidence = 0
wind