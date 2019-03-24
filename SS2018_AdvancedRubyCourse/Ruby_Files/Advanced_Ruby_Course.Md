# Advanced Ruby Course Notes

## Things to do

### Explore how to test a scipt which requires user input/ includes exits (is this an issue with using require?)

### https://prograils.com/posts/ruby-methods-differences-load-require-include-extend


### Insert ex37 glossary into notes

### Create Logic Truth Table index cards

See ex27 of LRTHW

### Search github for Ruby projects
See if you can interpret the scripts written in Ruby and use this to help understand how ruby is practically implimented. 

### Ex 24

Look into using % and the importance of the letter following the %. EG:
```
def secret_formula(started)
    jelly_beans = started * 500
    jars = jelly_beans / 1000
    crates = jars / 100
    return jelly_beans, jars, crates
end

start_point = 10000
beans, jars, crates = secret_formula(start_point)

puts "With a starting point of: #{start_point}"
puts "We'd have #{beans} beans. #{jars} jars, and #{crates} crates."

start_point = start_point / 10
puts "We can also do that this way:"
puts "We'd have %s beans, %s jars, and %s crates." % secret_formula(start_point)
```
### Object-orientated programming
Read about "object-oriented programming" online. Confused? I was too. Do not worry. You will learn enough to be dangerous, and you can slowly learn more later.

## Glossary


## Learn Ruby Hard Way 

### Ex 15 - Reading a file

```
filename = ARGV.first

txt = open(filename)

puts "Here is your file #{filename}:"
print txt.read

puts """
Do you have any other files you'd like to read.
If so, enter the name now: 
"""

filename_2 = $stdin.gets.chomp

txt_2 = open(filename_2)

puts "Here is your file #{filename_2}:"
print txt_2.read
```
### Ex 16 - Writing to a file

```
filename = ARGV.first

puts "We're going to erase #{filename}" 
puts "If you don't want that, hit CTRL-C (^C)." 
puts "If you do want that, hit RETURN."

$stdin.gets

puts "Opening the file..."
target = open(filename, 'w')

puts "Truncating the file. Goodbye!"
target.truncate(0)

puts "Enter new text - you have 3 lines of input..."

print "Line 1: "
line1 = $stdin.gets.chomp
print "Line 2: "
line2 = $stdin.gets.chomp
print "Line 3: "
line3 = $stdin.gets.chomp

puts "Now writing to file..."

target.write("#{line1}\n #{line2}\n #{line3}")
puts "Now closing file..."

target.close
```
### Ex 17 - Copying a file

```
from_file, to_file = ARGV

puts "Copying from #{from_file} to #{to_file}"
# we could do these two on one line, how? 
in_file = open(from_file) 
indata = in_file.read

puts "The input file is #{indata.length} bytes long"

puts "Does the output file exist? #{File.exist?(to_file)}" 
puts "Ready, hit RETURN to continue, CTRL-C to abort." 

$stdin.gets
out_file = open(to_file, 'w')
out_file.write(indata)

puts "Alright, all done."

out_file.close
in_file.close
```

Compressed to 3 lines, the above looks like this:

```
from_file, to_file = ARGV
indata = File.read(from_file) 
File.write(to_file, indata, mode: 'w')
```

### Useful Stuff
-----
#### Reading Backwards
1. Reading code backwards can help separate yourself from the program as a whole and focus in on the code itself 
-----
#### Format strings
I will now show you how to create a format string, but rather than using variables, use values by their names. Some of this is a bit more advanced, but don't worry you'll learn what all of these mean later. Just type this in, make it work, and write a comment above each line translating it to English.
```
formatter = "%{first} %{second} %{third} %{fourth}"

puts formatter % {first: 1, second: 2, third: 3, fourth: 4}
puts formatter % {first: "one", second: "two", third: "three", fourth: "four"}
puts formatter % {first: true, second: false, third: true, fourth: false}
puts formatter % {first: formatter, second: formatter, third: formatter, fourth: formatter}

puts formatter % {
  first: "I had this thing.",
  second: "That you could type up right.",
  third: "But it didn't sing.",
  fourth: "So I said goodnight."
}
```
produces:
```
1 2 3 4
one two three four
true false true false
%{first} %{second} %{third} %{fourth} %{first} %{second} %{third} %{fourth} %{first} %{second} %{third} %{fourth} %{first} %{second} %{third} %{fourth}
I had this thing. That you could type up right. But it didn't sing. So I said goodnight.
```
-----
#### Ex 24 - heredoc - assigning multi-line strings to variables

```
poem = <<END
\tThe lovely world
with logic so firmly planted
cannot discern \n the needs of love
nor comprehend passion from intuition
and requires an explanation
\n\ttwhere there is none.
END
```
You can use any word, not just END.
#### Basic Text Markup in Ruby

```
\n
```
within a string starts a new line.

For Example:
```
days = "Mon Tue Wed Thu Fri Sat Sun"
months = "Jan\nFeb\nMar\nApr\nMay\nJun\nJul\nAug"

puts "Here are the days: #{days}"
puts "Here are the months: #{months}"
```
returns

```
Here are the days: Mon Tue Wed Thu Fri Sat Sun
Here are the months: Jan
Feb
Mar
Apr
May
Jun
Jul
Aug
```

This \ (backslash) character encodes difficult-to-type characters into a string. There are various "escape sequences" available for different characters you might want to use. 

An important escape sequence is to escape a single-quote ' or double-quote ". Imagine you have a string that uses double-quotes and you want to put a double-quote inside the string. If you write "I "understand" joe." then Ruby will get confused because it will think the " around "understand" actually ends the string. You need a way to tell Ruby that the " inside the string isn't a real double-quote.

To solve this problem you escape double-quotes and single-quotes so Ruby knows to include them in the string. Here's an example:
```
"I am 6'2\" tall."  # escape double-quote inside string
'I am 6\'2" tall.'  # escape single-quote inside string
```
both return
```
I am 6'2" tall.
```
This is all of the escape sequences Ruby supports. You may not use many of these, but memorize their format and what they do anyway. Try them out in some strings to see if you can make them work.

Escape	What it does.
\\	Backslash ()
\'	Single-quote (')
\"	Double-quote (")
\a	ASCII bell (BEL)
\b	ASCII backspace (BS)
\f	ASCII formfeed (FF)
\n	ASCII linefeed (LF)
\r	ASCII Carriage Return (CR)
\t	ASCII Horizontal Tab (TAB)
\uxxxx	Character with 16-bit hex value xxxx (Unicode only)
\v	ASCII vertical tab (VT)
\ooo	Character with octal value ooo
\xhh	Character with hex value hh

To create 

```
%p{} 
```
produces as quote with formating exactly as typed within the {}

For example:
```
puts %q{
There's something going on here.
With this weird quote
We'll be able to type as much as we like.
Even 4 lines if we want, or 5, or 6.
}
```
Produces:
```
There's something going on here.
With this weird quote
We'll be able to type as much as we like.
Even 4 lines if we want, or 5, or 6.
```
The second way is by using triple-quotes, which is just """ and works like a string, but you also can put as many lines of text as you want until you type """ again. We'll also play with these.

Eg
```
fat_cat = """
I'll do a list:
\t* Cat food
\t* Fishies
\t* Catnip\n\t* Grass
"""
```
Returns 
```
I'll do a list:
        * Cat food
        * Fishies
        * Catnip
        * Grass
```
----

#### Argument Variables - an alternative means to gaining using input

The ARGV is the "argument variable," a very standard name in programming that you will find used in many other languages. This variable holds the arguments you pass to your Ruby script when you run it.

EG
```
first, second, third = ARGV

puts "Your first variable is: #{first}"
puts "Your second variable is: #{second}"
puts "Your third variable is: #{third}"
```
Line 1 "unpacks" ARGV so that, rather than holding all the arguments, it gets assigned to three variables you can work with: first, second, and third. This may look strange, but "unpack" is probably the best word to describe what it does. It just says, "Take whatever is in ARGV, unpack it, and assign it to all of these variables on the left in order."

The argument variables are assigned at command line level when running the script.
EG
```
$ ruby ex13.rb stuff things that
Your first variable is: stuff
Your second variable is: things
Your third variable is: that
```
and
```
$ ruby ex13.rb apple orange grapefruit
Your first variable is: apple
Your second variable is: orange
Your third variable is: grapefruit
```
What's the difference between ARGV and gets.chomp? The difference has to do with where the user is required to give input. If they give your script inputs on the command line, then you use ARGV. If you want them to input using the keyboard while the script is running, then use gets.chomp.

N.B<br/>You should use ARGV doesn't work well with gets.chomp, so in it's place use
```
$stdin.gets.chomp 
```
when user input is required in addition to Argument Varviables. 

If you only want to include one command line argument, you need to use ARGV.first - as shown below:
```
user_name = ARGV.first
prompt = '> '

puts "Hi #{user_name}."
puts "I'd like to ask you a few questions."
puts "Do you like me #{user_name}? "
puts prompt 
likes = $stdin.gets.chomp

puts "Where do you live #{user_name}? "
puts prompt 
lives = $stdin.gets.chomp

# a comma for puts is like using it twice 
puts "What kind of computer do you have? ", prompt 
computer = $stdin.gets.chomp
puts """ 
    Alright, so you said #{likes} about liking me. 
    You live in #{lives}. Not sure where that is. 
    And you have a #{computer} computer. Nice.

```
#### Puts and commas
a comma for puts is like using it twice
EG
```
puts "What kind of computer do you have? ", prompt
```

#### Ex25 - Importing Functions through Modules

Modules can be used to carry across functions between scripts. EG:

```
module Ex25 # saved within ex25.rb
    
    # This function will break up words for us. 
    def Ex25.break_words(stuff)
        words = stuff.split(' ') 
        return words
    end

    # Sorts the words. 
    def Ex25.sort_words(words) 
        return words.sort
    end

    # Prints the first word after shifting it off. 
    def Ex25.print_first_word(words)
        word = words.shift 
        puts word
    end
    # Prints the last word after popping it off. 
    def Ex25.print_last_word(words) 
        word = words.pop 
        puts word
    end

    # Takes in a full sentence and returns the sorted words. 
    def Ex25.sort_sentence(sentence) 
        words = Ex25.break_words(sentence) 
        return Ex25.sort_words(words)
    end
    # Prints the first and last words of the sentence. 
    def Ex25.print_first_and_last(sentence) 
        words = Ex25.break_words(sentence) 
        Ex25.print_first_word(words) 
        Ex25.print_last_word(words)
    end
    # Sorts the words then prints the first and last one. 
    def Ex25.print_first_and_last_sorted(sentence)
        words = Ex25.sort_sentence(sentence) 
        Ex25.print_first_word(words) 
        Ex25.print_last_word(words)
    end 
end
```
Then in the follow up script you 'require' the ruby script to access the functions located within the module. EG:

```
require "./ex25.rb"
sentence = "All good things come to those who wait." 
words = Ex25.break_words(sentence) 
words 
sorted_words = Ex25.sort_words(words)
sorted_words 
Ex25.print_first_word(words) 
Ex25.print_last_word(words) 
words 
Ex25.print_first_word(sorted_words) 
Ex25.print_last_word(sorted_words) 
sorted_words sorted_words = Ex25.sort_sentence(sentence) 
sorted_words Ex25.print_first_and_last(sentence) 
Ex25.print_first_and_last_sorted(sentence)
```
#### Ex 31 - if statements - story based game

```
puts "You enter a dark room with two doors. Do you go through door #1 or door #2?"

print "> "
door = $stdin.gets.chomp

if door == "1"
    puts "There's a giant bear here eating a cheese cake. What do you do?" 
    puts "1. Take the cake." 
    puts "2. Scream at the bear."

    print "> "
    bear = $stdin.gets.chomp

    if bear == "1"
        puts "The bear eats your face off. Good job!"
    elsif bear == "2" 
        puts "The bear eats your legs off. Good job!"
    else puts "Well, doing %s is probably better. Bear runs away." % bear
    end

elsif door == "2"
    puts "You stare into the endless abyss at Cthulhu's retina." 
    puts "1. Blueberries." 
    puts "2. Yellow jacket clothespins." 
    puts "3. Understanding revolvers yelling melodies."

    print "> "
    insanity = $stdin.gets.chomp

    if insanity == "1" || insanity == "2"
        puts "Your body survives powered by a mind of jello. Good job!"
    else
        puts "The insanity rots your eyes intp a pool of muck. Good job!"
    end

else
    puts "You stumle around and fall on a knife and die. Good job!"
end
```
#### While true - infinite loop

You can use while true to produce an infinite loop within a block. Eg:

``` 
    while true 
        print "> " 
        choice = $stdin.gets.chomp

        if choice == "take honey"
            dead("The bear looks at you then slaps your face off.")
        elsif choice == "taunt bear" && !bear_moved
            puts "The bear has moved from the door. You can go through it now." 
            bear_moved = true
        elsif choice == "taunt bear" && bear_moved 
            dead("The bear gets pissed off and chews your leg off.")
        elsif choice == "open door" && bear_moved 
            gold_room
        else 
            puts "I got no idea what that means."
        end 
    end

```
The above loops back to the user input until another function is called to exit the loop.

Some basic rules for looping:

1. Use a while-loop only to loop forever, and that means probably never. This only applies to Ruby; other languages are different
2. Use a for-loop for all other kinds of looping, especially if there is a fixed or limited number of things to loop over.

#### Aborting

On many operating systems a program can abort with exit(0) , and the number passed in will indicate an error or not. If you do exit(1) then it will be an error, but exit(0) will be a good exit. The reason it's backward from normal Boolean logic (with 0==false ) is that you can use different numbers to indicate different error results. You can do exit(100) for a different error result than exit(2).

#### Rules for If statements

1. Every if-statement must have an else. 
2. If this else should never run because it doesn't make sense, then you must use a die function in the else that prints out an error message and dies, just like we did in the last exercise. This will find many errors.
3. Never nest if-statements more than two deep and always try to do them one deep.
4. Treat if-statements like paragraphs, where each if-elsif-else grouping is like a set of sentences. Put blank lines before and after.
5. Your Boolean tests should be simple. If they are complex, move their calculations to variables earlier in your function and use a good name for the variable.

#### Tips for debugging

1. Don't use a "debugger." A debugger is like doing a full-body scan on a sick person. You do not get any specific useful information, and you find a whole lot of information that doesn't help and is just confusing.
2. The best way to debug a program is to use put to print out the values of variables at points in the program to see where they go wrong. 3 Make sure parts of your programs work as you work on them. Do not write massive files of code before you try to run them. Code a little, run a little, fix a little.

#### Rules for Arrays

You use an array whenever you have something that matches the array data structure's useful features: 

1. If you need to maintain order. Remember, this is listed order, not sorted order. Arrays do not sort for you. 
2. If you need to access the contents randomly by a number. Remember, this is using cardinal numbers starting at 0. 
3. If you need to go through the contents linearly (first to last). Remember, that's what for-loops are for.

Then that's when you use an array

#### Hashes

Default values can be assigned using:
```
||= 
```
eg
```
city ||= 'Does Not Exist'
```
#### Classes and Objects - Ex 42

A Ruby object has three components: a set of flags, some instance variables, and an associated class. A Ruby class is an object of class Class, which contains all the object things plus a list of methods and a reference to a superclass (which is itself another class). All method calls in Ruby nominate a receiver (which is by default self, the current object). Ruby finds the method to invoke by looking at the list of methods in the receiver's class. If it doesn't find the method there, it looks in the superclass, and then in the superclass's superclass, and so on. If the method cannot be found in the receiver's class or any of its ancestors, Ruby invokes the method method_missing on the original receiver.

##### Object-Specific Classes

Ruby allows you to create a class tied to a particular object. In the following example, we create two String objects. We then associate an anonymous class with one of them, overriding one of the methods in the object's base class and adding a new method.

```
a = "hello"
b = a.dup
class <<a
  def to_s
    "The value is '#{self}'"
  end
  def twoTimes
    self + self
  end
end
a.to_s	»	"The value is 'hello'"
a.twoTimes	»	"hellohello"
b.to_s	»	"hello"
```
This example uses the \``class << obj'' notation, which basically says `` build me a new class just for object obj.'' We could also have written it as:

```
a = "hello"
b = a.dup
def a.to_s
  "The value is '#{self}'"
end
def a.twoTimes
  self + self
end
a.to_s	»	"The value is 'hello'"
a.twoTimes	»	"hellohello"
b.to_s	»	"hello"

```
The effect is the same in both cases: a class is added to the object ``a''. This gives us a strong hint about the Ruby implementation: a singleton class is created and inserted as a's direct class. a's original class, String, is made this singleton's superclass.

##### The Super Method

###### Implicit arguments
When a method with arguments is overridden by one of its child classes then a call to super without any argument in the child method will automatically pass the arguments of the child method to the parent method.

Let’s have a look to the following example:
```
class Parent
    def say(message)
        p message
    end
end

class Child < Parent
    def say(message)
        super
    end
end

Child.new.say('Hi Rubyist!') #=> "Hi Rubyist!"
```

1. Here the Child class inherits from the Parent class.

2. The Child class overrides the Parent#say method.

3. Within the Child#say method, we call super without any argument.

4. So, Ruby tries to find a method #say in the ancestor chain of the Child class.

5. Then it passes the message argument to the freshly found method.

But, what if the Parent#say method doesn’t expect any argument ?

###### super vs super()

Let’s redefine the Parent#say method by removing the message argument

```
class Parent
    def say
        p "I'm the parent"
    end
end

class Child < Parent
    def say(message)
        super
    end
end

Child.new.say('Hi Rubyist!') #=> ArguementError (wrong number of arguments (given 1, expected 0))

```

An ArgumentError is raised because the Parent#say method doesn’t expect any argument.

In effect, the call to super in the Child#say method implicitly passes the message argument from the Child#say method to the Parent#say method.

To avoid this problem, we can explicitly indicate to super to don’t take any argument from the Child#say method.

To do so, we can add parentheses to the super keyword — super()

```
class Parent
    def say
        p "I'm the parent"
    end
end

class Child < Parent
    def say(message)
        super()
    end
end

Child.new.say('Hi!') #=> "I'm the parent"
```

So let’s try to pass a block to our Parent#say method.

###### Super with blocks

Let’s redefine the Parent#say method by adding a yield keyword in it

```
class Parent
    def say
        yield
    end
end

class Child < Parent
    def say
        super
    end
end

Child.new.say {p 'Hi! Glad to know you Parent'} #=> "Hi! Glad to know you Parent"
```

The block passed to the Child.new.say method is implicitly passed to the Parent#say method through the super keyword.

Then we use the yield keyword to catch the block and execute it in the Parent#say method.

###### Super with the ancestors chain
Let’s make the Parent class inherit from the GrandParent class — which defines the #say method
```
class GrandParent
    def say(message)
        p "GrandParent: #{message}"
    end
end

class Parent < GrandParent
end

class Child < Parent
    def say(message)
        super
    end
end

Child.new.say('Hi Rubyist!') # => "GrandParent: Hi Rubyist!"

```
Here we can see that the super keyword tries to find the #say method in the Parent class.

The Parent class doesn’t define this method.

So super tries to find the #say method in the superclass of the Parent class — the GrandParent class.

The GrandParent class defines the #say method.

So, The 'Hi Rubyist!' argument passed to the Child.new.say method call is implicitly passed to the GrandParent#say method through the super keyword.

Voilà!

###### Using super() with initialize
The most common use of super() is actually in initialize functions in base classes. This is usually the only place where you need to do some things in a child, then complete the initialization in the parent. Here's a quick example of doing that in the Child from these examples:

```
class Child < Parent
    def initialize(stuff)
        @stuff = stuff
        super()
    end
end
```

This is the same as the Child.altered example above, except I'm setting some variables in the initialize before having the Parent initialize with its Parent.initialize.

##### Inheritance VS Composition LRTHW Ex 44

Inheritance is useful, but another way to do the exact same thing is just to use other classes and modules, rather than rely on implicit inheritance. If you look at the three ways to exploit inheritance, two of the three involve writing new code to replace or alter functionality. This can easily be replicated by just calling functions in a module. Here's an example of doing this:

```
class Other

  def override()
    puts "OTHER override()"
  end

  def implicit()
    puts "OTHER implicit()"
  end

  def altered()
    puts "OTHER altered()"
  end
end

class Child

  def initialize()
    @other = Other.new()
  end

  def implicit()
    @other.implicit()
  end

  def override()
    puts "CHILD override()"
  end

  def altered()
    puts "CHILD, BEFORE OTHER altered()"
    @other.altered()
    puts "CHILD, AFTER OTHER altered()"
  end
end

son = Child.new()

son.implicit()
son.override()
son.altered()

```

In this code I'm not using the name Parent, since there is not a parent-child is-a relationship. This is a has-a relationship, where Child has-a Other that it uses to get its work done. When I run this I get the following output:

```
$ ruby ex44e.rb
OTHER implicit()
CHILD override()
CHILD, BEFORE OTHER altered()
OTHER altered()
CHILD, AFTER OTHER altered()
```

You can see that most of the code in Child and Other is the same to accomplish the same thing. 

Ruby has another way to do composition using modules and a concept called mixins. You simply create a module with functions that are common to classes and then include them in your class similar to using a require. Here's this same composition example done using modules and mixins.

```

module Other

  def override()
    puts "OTHER override()"
  end

  def implicit()
    puts "OTHER implicit()"
  end

  def Other.altered()
    puts "OTHER altered()"
  end
end

class Child
  include Other

  def override()
    puts "CHILD override()"
  end

  def altered()
    puts "CHILD, BEFORE OTHER altered()"
    Other.altered()
    puts "CHILD, AFTER OTHER altered()"
  end
end

son = Child.new()

son.implicit()
son.override()
son.altered()

```
This is similar to the previous composition example. 

###### When to Use Inheritance or Composition

The question of "inheritance versus composition" comes down to an attempt to solve the problem of reusable code. You don't want to have duplicated code all over your software, since that's not clean and efficient. Inheritance solves this problem by creating a mechanism for you to have implied features in base classes. Composition solves this by giving you modules and the capability to call functions in other classes.

If both solutions solve the problem of reuse, then which one is appropriate in which situations? The answer is incredibly subjective, but I'll give you my three guidelines for when to do which:

1. Avoid something called "meta-programming" at all costs, as it is too complex to be useful reliably. If you're stuck with it, then be prepared to know the class hierarchy and spend time determining where everything is coming from.
2. Use composition to package up code into modules that are used in many different unrelated places and situations.
3. Use inheritance only when there are clearly related reusable pieces of code that fit under a single common concept or if you have to because of something you're using.

Do not be a slave to these rules. The thing to remember about object-oriented programming is that it is entirely a social convention programmers have created to package and share code. Because it's a social convention, but one that's codified in Ruby, you may be forced to avoid these rules because of the people you work with. In that case, find out how they use things and then just adapt to the situation.

#### Responding to Exceptions

 An exception is an error that you get from some function you may have run. What happens is your function "raises" an exception when it encounters an error, then you have to handle that exception. For example, if you type this into Ruby you get an exception:

```
>> Integer("hell")
ArgumentError: invalid value for Integer(): "hell"
     from (irb):1:in `Integer'
     from (irb):1
     from /usr/bin/irb:12:in `<main>'
```

That ArgumentError is an exception that the Integer() function threw because what you handed Integer() is not a number. The Integer()) function could have returned a value to tell you it had an error, but since it only returns integers, it'd have a hard time doing that. It can't return -1 since that's a number. Instead of trying to figure out what to return when there's an error, the Integer() function raises the ArgumentError exception and you deal with it.

You deal with an exception by using the begin and rescue keywords:
```
def convert_number(object)
  begin
    return Integer(object)
  rescue
    return nil
  end
end
```

You put the code you want to "try" inside the begin block, and then you put the code to run for the error inside the rescue. In this case, we want to "try" to call Integer() on something that might be a number. If that has an error, then we "catch" it and return nil.

