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
end

class CentralCorridor < Scene
  def enter()
    puts "This is the Central Corridor Scene"
    return 'lazer_weapon_armory'
  end
end

class LaserWeaponArmory < Scene
  def enter()
    puts "This is the Laser Weapon Armory Scene"
    return 'the_bridge'
  end
end

class TheBridge < Scene
  def enter()
    puts "This is the Bridge Scene"
    return 'escape_pod' 
  end
end

class EscapePod < Scene
  def enter()
    puts "This is the EscapePod Scene"
    return 'credits' 
  end
end

class Death < Scene
  # give use the option to chose to start the scene again, start the game again or exit
end

class Credits < Scene
  def enter()
    puts "\t\t...This was a REESWAG production..."
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
    exit
  end
end

class Map
  
  @@scenes = {'central_corridor' => CentralCorridor.new(), 'lazer_weapon_armory' => LaserWeaponArmory.new(), 'the_bridge' => TheBridge.new(), 'escape_pod' => EscapePod.new(), 'death' => Death.new(), 'credits' => Credits.new}

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

trial_map = Map.new('central_corridor')
trial_game = Engine.new(trial_map)
trial_game.play()

puts "Did it work?????"

a_map = Map.new('CentralCorridor')
a_game = Engine.new(a_map)
a_game.play()

=begin

NOTES

Aliens have invaded a space ship and our hero has to go through a maze of rooms defeating them so he can escape into an escape pod to the planet below. 
The game will be more like a Zork or Adventure type game with text outputs and funny ways to die. 
The game will involve an engine that runs a map full of rooms or scenes. 
Each room will print its own description when the player enters it and then tell the engine what room to run next out of the map.

----Concept List----

* Map - the purpose of the map class is to hold all the scenes as objects and provide series of functions to move through them. 
  - initialize
  - next_scene
  - opening_scene
* Engine - the engine initiates the game and guides the script through the various scenes.
  - play
    - initiate game with 
* Scene - the scenes provide the gameplay
  - enter - a universal function that provides a scene specific statement
  * Death
  * Central Corridor
  * Laser Weapon Armory
  * The Bridge
  * Escape Pod

----Scenes----

Death - This is when the player dies and should be something funny.

Central Corridor - This is the starting point and has a Gothon already standing there that the players have to defeat with a riddle before continuing.
- Opening Text
- Prompt User for answer to riddle
  - if correct -> next scene
  - if false -> death(by gorgon)

Laser Weapon Armory - This is where the hero gets a neutron bomb to blow up the ship before getting to the escape pod. It has a keypad the hero has to guess the number for.
- Opening text - Give the riddle - the key should be a 4 digit code - based on today's date - ie 1st Jan = 0101
- Prompt User to enter keycode
  if correct -> obtain neutron bomb -> next scene
  if false -> user obtains dummy bomb

The Bridge - Another battle scene with a Gothon where the hero places the bomb.
- Descriptive text 
- Prompt user to to place bomb
    if bomb = real -> next scene
    if bomb = dummy -> death

Escape Pod - Where the hero escapes but only after guessing the right escape pod.
- Opening text
- Prompt user to chose an escape pod (2/5 are booby trapped) - possibly randomly (to avoid walkthroughs)
  - if choice = correct -> safety -> endgame
  - else death 


----Scene Heirarchy----

Central Corridor -> Laser Weapon Armory -> Bridge -> Escape Pod

=end