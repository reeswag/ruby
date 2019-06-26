module Map
    class Room 

        def initialize(name, description)
            @name = name
            @description = description
            @paths = {}
        end

        # these make it easy for you to access the variables
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

    GT_CENTRAL_CORRIDOR = Room.new("Central Corridor",
        """
        The Gothons of Planet Percal #25 have invaded your ship and destroyed
        your entire crew.  You are the last surviving member and your last
        mission is to get the neutron destruct bomb from the Weapons Armory,
        put it in the bridge, and blow the ship up after getting into an 
        escape pod.
    
        You're running down the central corridor to the Weapons Armory when
        a Gothon jumps out, red scaly skin, dark grimy teeth, and evil clown costume
        flowing around his hate filled body.  He's blocking the door to the
        Armory and about to pull a weapon to blast you.
        """)
    
    
    GT_LASER_WEAPON_ARMORY = Room.new("Laser Weapon Armory",
        """
        Lucky for you they made you learn Gothon insults in the academy.
        You tell the one Gothon joke you know:
        Lbhe zbgure vf fb sng, jura fur fvgf nebhaq gur ubhfr, fur fvgf nebhaq gur ubhfr.
        The Gothon stops, tries not to laugh, then busts out laughing and can't move.
        While he's laughing you run up and shoot him square in the head
        putting him down, then jump through the Weapon Armory door.
    
        You do a dive roll into the Weapon Armory, crouch and scan the room
        for more Gothons that might be hiding.  It's dead quiet, too quiet.
        You stand up and run to the far side of the room and find the
        neutron bomb in its container.  There's a keypad lock on the box
        and you need the code to get the bomb out.  If you get the code
        wrong 10 times then the lock closes forever and you can't
        get the bomb.  The code is 3 digits.
        """)
    
    
    GT_THE_BRIDGE = Room.new("The Bridge",
        """
        The container clicks open and the seal breaks, letting gas out.
        You grab the neutron bomb and run as fast as you can to the
        bridge where you must place it in the right spot.
    
        You burst onto the Bridge with the netron destruct bomb
        under your arm and surprise 5 Gothons who are trying to
        take control of the ship.  Each of them has an even uglier
        clown costume than the last.  They haven't pulled their
        weapons out yet, as they see the active bomb under your
        arm and don't want to set it off.
        """)
    
    
    GT_ESCAPE_POD = Room.new("Escape Pod",
        """
        You point your blaster at the bomb under your arm
        and the Gothons put their hands up and start to sweat.
        You inch backward to the door, open it, and then carefully
        place the bomb on the floor, pointing your blaster at it.
        You then jump back through the door, punch the close button
        and blast the lock so the Gothons can't get out.
        Now that the bomb is placed you run to the escape pod to
        get off this tin can.
    
        You rush through the ship desperately trying to make it to
        the escape pod before the whole ship explodes.  It seems like
        hardly any Gothons are on the ship, so your run is clear of
        interference.  You get to the chamber with the escape pods, and
        now need to pick one to take.  Some of them could be damaged
        but you don't have time to look.  There's 5 pods, which one
        do you take?
        """)
    
    
    GT_THE_END_WINNER = Room.new("The End",
        """
        You jump into pod 2 and hit the eject button.
        The pod easily slides out into space heading to
        the planet below.  As it flies to the planet, you look
        back and see your ship implode then explode like a
        bright star, taking out the Gothon ship at the same
        time. Winner winner chicken dinner!

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
        --  __                      ___--  ^  ^
        """
        )
    
    
    GT_THE_END_LOSER = Room.new("The End",
        """
        You jump into a random pod and hit the eject button.
        The pod escapes out into the void of space, then
        implodes as the hull ruptures, crushing your body
        into jam jelly.
        """
        )

    GT_ESCAPE_POD.add_paths({
        '*' => GT_THE_END_LOSER,
        '2' => GT_THE_END_WINNER
    })
    
    GT_GENERIC_DEATH = Room.new("Death", "You died.")

    GT_SHOOT_DEATH = Room.new("Death", 
        """
        Quick on the draw you yank out your blaster and fire it at the Gothon.
        His clown costume is flowing and moving around his body, which throws
        off your aim.  Your laser hits his costume but misses him entirely.  This
        completely ruins his brand new costume his mother bought him, which
        makes him fly into an insane rage and blast you repeatedly in the face until
        you are dead.  Then he eats you.
        """
        )

    GT_DODGE_DEATH = Room.new("Death", 
        """
        Like a world class boxer you dodge, weave, slip and slide right
        as the Gothon's blaster cranks a laser past your head.
        In the middle of your artful dodge your foot slips and you
        bang your head on the metal wall and pass out.
        You wake up shortly after only to die as the Gothon stomps on
        your head and eats you.
        """
        )
        
    GT_CODE_DEATH = Room.new("Death", 
        """
        The lock buzzes one last time and then you hear a sickening
        melting sound as the mechanism is fused together.
        You decide to sit there, and finally the Gothons blow up the
        ship from their ship and you die.
        """
        )
    
    GT_BOMB_DEATH = Room.new("Death", 
        """
        In a panic you throw the bomb at the group of Gothons
        and make a leap for the door.  Right as you drop it a
        Gothon shoots you right in the back killing you.
        As you die you see another Gothon frantically try to disarm
        the bomb. You die knowing they will probably blow up when
        it goes off.
        """  
        )

    GT_THE_BRIDGE.add_paths({
        'throw the bomb' => GT_BOMB_DEATH,
        'slowly place the bomb' => GT_ESCAPE_POD
    })

    GT_LASER_WEAPON_ARMORY.add_paths({
        '123' => GT_THE_BRIDGE,
        '*' => GT_CODE_DEATH
    })

    GT_CENTRAL_CORRIDOR.add_paths({
        'shoot!' => GT_SHOOT_DEATH,
        'dodge!' => GT_DODGE_DEATH,
        'tell a joke' => GT_LASER_WEAPON_ARMORY
    })

    HTY_TITLE = Room.new("Title",
        """
        Colchester, the 15th century.Meet Humpty Dumpty, an ordinary walking, talking egg. Can you help Humpty become the stuff of legends?
        Make the right choices and, with a bit of luck, children will be talking about him for centuries...
        Press enter to start Humpty's Tale...
        """)

        HTY_INTRO = Room.new("Intro",
        """
        Should Humpty Dumpty sit on the wall?
        """)

    HTY_WALL = Room.new("Wall",
        """
        Has Humpty been drinking?
        """)

    HTY_FALL = Room.new("Fall",
        """
        All the king's horses and all the king's men
        """)

    HTY_THE_END_WINNER = Room.new("The End",
        """
        Couldn't put Humpty together again.
        Chicken Dinner
        """)

    HTY_GENERIC_ENDING = Room.new("The End",
        """
        Game Over...
        """)

    HTY_TITLE.add_paths({
        'Enter'=> HTY_INTRO,
        'End Game' => HTY_GENERIC_ENDING
    })

    HTY_INTRO.add_paths({
        'Sit'=> HTY_WALL,
        'Go Home' => HTY_GENERIC_ENDING
    })

    HTY_WALL.add_paths({
        'Just a few...' => HTY_FALL,
        'Sober as a nun' => HTY_GENERIC_ENDING
    })

    HTY_FALL.add_paths({
        'Heads'=> HTY_THE_END_WINNER,
        'Tails' => HTY_GENERIC_ENDING
    })

    # A whitelist of allowed room names. We use this so that
    # bad people on the internet can't access random variables
    # with names.  You can use Test::constants and Kernel.const_get
    # too.

    ROOM_NAMES = {
        'GT_CENTRAL_CORRIDOR' => GT_CENTRAL_CORRIDOR,
        'GT_LASER_WEAPON_ARMORY' => GT_LASER_WEAPON_ARMORY,
        'GT_THE_BRIDGE' => GT_THE_BRIDGE,
        'GT_ESCAPE_POD' => GT_ESCAPE_POD,
        'GT_THE_END_WINNER' => GT_THE_END_WINNER,
        'GT_THE_END_LOSER' => GT_THE_END_LOSER,
        'GT_SHOOT_DEATH' => GT_SHOOT_DEATH,
        'GT_DODGE_DEATH' => GT_DODGE_DEATH,
        'GT_CODE_DEATH' => GT_CODE_DEATH,
        'GT_BOMB_DEATH' => GT_BOMB_DEATH,
        'HTY_TITLE' => HTY_TITLE,
        'HTY_INTRO' => HTY_INTRO,
        'HTY_WALL' => HTY_WALL,
        'HTY_FALL' => HTY_FALL,
        'HTY_THE_END_WINNER' => HTY_THE_END_WINNER,
        'HTY_GENERIC_ENDING' => HTY_GENERIC_ENDING
    }

    def Map::load_room(session) # Given a session this will return the right room or nil
        return ROOM_NAMES[session[:room]]
    end

    def Map::save_room(session, room) # Store the room in the session for later, using its name
        session[:room] = ROOM_NAMES.key(room)
    end
end