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

### Constants:
A Ruby constant is like a variable, except that its value is supposed to remain constant for the duration of the program. The Ruby interpreter does not actually enforce the constancy of constants, but it does issue a warning if a program changes the value of a constant.
```
A_CONST = 10  
A_CONST = 20  
```
Produces a warning:
```
warning: already initialized constant A_CONST  
```
Lexically, the names of constants look like the names of local variables, except that they begin with a capital letter. By convention, most constants are written in all uppercase with underscores to separate words, LIKE_THIS. Ruby class and module names are also constants, but they are conventionally written using initial capital letters and camel case, LikeThis.

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

#### Test Driven Development

Test first is a programming tactic where you write an automated test that pretends the code works, then you write the code to make the test actually work. This method works when you can't visualize how the code is implemented, but you can imagine how you have to work with it. For example, if you know how you need to use a new class in another module, but you don't quite know how to implement that class yet, then write the test first.

You are going to take a test I give you and use it to write the code that makes it work. To do this exercise you're going to follow this procedure:

1. Create one small part of the test I give you.
2. Make sure it runs and fails so you know that the test is actually confirming a feature works.
3. Go to your source file lexicon.rb and write the code that makes this test pass.
4. Repeat until you have implemented everything in the test.

When you get to 3 it's also good to combine our other method of writing code:

1. Make the "skeleton" function or class that you need.
2. Write comments inside describing how that function works.
3. Write the code that does what the comments describe.
4. Remove any comments that just repeat the code.

This method of writing code is called "psuedo code" and works well if you don't know how to implement something, but you can describe it in your own words.

Combining the "test first" with the "psuedo code" tactics we have this simple process for programming:

1. Write a bit of test that fails.
2. Write the skeleton function/module/class the test needs.
3. Fill the skeleton with comments in your own words explaining how it works.
4. Replace the comments with code until the test passes.
5. Repeat.


#### Testing for Exceptions - LRTHW - Ex49

Use exception classes to raise exceptions:

```
class ParserError < Exception
end

def parse_verb(word_list)
    skip(word_list, 'stop')

    if peek(word_list) == 'verb'
        return match(word_list, 'verb')
    else
        raise ParserError.new("Expected a verb next.")
    end
end
```

Doing so is an important part of test driven development as it allows you to write a test that is expected to fail under a given scenario.

Check for an exception by using the function assert_raise from the Test::Unit as follows:

```
assert_raise do
  test_list_3 = [['stop', 'the'],['verb', 'drive'],['noun', 'car']]
  parse_object(test_list_3)
end
```
placing the block of code expected to raise an exception within assert_raise do ... end 

eg:

```
incorrect_sentences = [[['noun', 'car']], 
  [['noun', 'car'], ['noun', 'player']], 
  [['verb', 'eat'], ['verb', 'eat']]
]

incorrect_sentences.each do |x|
  assert_raise do
    parse_sentence(x)
  end
end
```

Here we are testing that each of the array elements returns an expection when the parse_sentence() method is called. 

### Sinatra

Sinatra is a web framework. The term "framework" generally means "some package that makes it easier for me to do something." In the world of web applications, people create "web frameworks" to compensate for the difficult problems they've encountered when making their own sites. They share these common solutions in the form of a package you can download to bootstrap your own projects.

#### A basic web app

/projects/gothonweb/bin/app.ruby :

```
require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
    return 'Hello world'
end

get '/hello/' do
    greeting = params[:greeting] || "Hi There"
    erb :index, :locals => {'greeting' => greeting}
end
```
Run the application like this:

```
ruby bin/app.rb
```

How it works:

1. Your browser makes a network connection to your own computer, which is called localhost and is a standard way of saying "whatever my own computer is called on the network." It also uses port 8080.
2. Once it connects, it makes an HTTP request to the bin/app.rb application and asks for the / URL, which is commonly the first URL on any website.
3. Inside bin/app.rb you've got a list of URLs and what classes they match. The only one we have is the '/', 'index' mapping. This means that whenever someone goes to / with a browser, Sinatra will find the class index and load it to handle the request.
4. Now that Sinatra has found class index it calls the index.GET method on an instance of that class to actually handle the request. This function runs and simply returns a string for what Sinatra should send to the browser.
5. Finally, Sinatra has handled the request and sends this response to the browser, which is what you are seeing.

#### Rerun
When developing using Sinatra, it is important to remember that the entire web app needs to be reloaded whenever changes are made. Doing so can either be done with CTRL-C then running it again, or using the automated rerun gem as follows:

```
rerun 'ruby bin/app.rb'
```

#### Interpreting Errors in Sinatra

1. The top right of the page shows the main error and description
2. The BACKTRACE  section shows a trace of each line involved in the error, just as you'd expect with a ruby error.
3. GET 
4. Post
5. COOKIES

#### Passing parameters to HTML via Sinatra

This works by defining parameters and assignin them al locals within the relevant html view (as defined in the .erb file)
```
get '/hello/' do
    greeting = params[:greeting] || "Hi There"
    erb :index, :locals => {'greeting' => greeting}
end
```

These locals are then pushed to the html via the following syntax:

```
<%= greeting %>
```
#### Basic Web Theory

![alt text](https://learnrubythehardway.org/book/_static/python/http_flow_graphic.png "Web Diagram")


1. You type in the url http://test.com// into your browser, and it sends the request on line (A) to your computer's network interface.
2. Your request goes out over the internet on line (B) and then to the remote computer on line (C) where my server accepts the request.
3. Once my computer accepts it, my web application gets it on line (D), and my Ruby code runs the index.GET handler.
4. The response comes out of my Ruby server when I return it, and it goes back to your browser over line (D) again.
5. The server running this site takes the response off line (D), then sends it back over the internet on line (C).
6. The response from the server then comes off the internet on line (B), and your computer's network interface hands it to your browser on line (A).
7. Finally, your browser then displays the response.

**Browser**

The software that you're probably using every day. Most people don't know what a browser really does. They just call browsers "the internet." Its job is to take addresses (like http://test.com/) you type into the URL bar, then use that information to make requests to the server at that address.

**Address**

This is normally a URL (Uniform Resource Locator) like http://test.com// and indicates where a browser should go. The first part, http, indicates the protocol you want to use, in this case "Hyper-Text Transport Protocol." You can also try ftp://ibiblio.org/ to see how "File Transport Protocol" works. The http://test.com/ part is the "hostname," a human readable address you can remember and which maps to a number called an IP address, similar to a telephone number for a computer on the internet. Finally, URLs can have a trailing path like the /book/ part of http://test.com//book/, which indicates a file or some resource on the server to retrieve with a request. There are many other parts, but those are the main ones.

**Connection**

Once a browser knows what protocol you want to use (http), what server you want to talk to (http://test.com/), and what resource on that server to get, it must make a connection. The browser simply asks your operating system (OS) to open a "port" to the computer, usually port 80. When it works, the OS hands back to your program something that works like a file, but is actually sending and receiving bytes over the network wires between your computer and the other computer at http://test.com/. This is also the same thing that happens with http://localhost:8080/, but in this case you're telling the browser to connect to your own computer (localhost) and use port 8080 rather than the default of 80. You could also do http://test.com:80/ and get the same result, except you're explicitly saying to use port 80 instead of letting it be that by default.

**Request**

Your browser is connected using the address you gave. Now it needs to ask for the resource it wants (or you want) on the remote server. If you gave /book/ at the end of the URL, then you want the file (resource) at /book/, and most servers will use the real file /book/index.html but pretend it doesn't exist. What the browser does to get this resource is send a request to the server. I won't get into exactly how it does this, but just understand that it has to send something to query the server for the request. The interesting thing is that these "resources" don't have to be files. For instance, when the browser in your application asks for something, the server is returning something your Ruby code generated.

**Server**

The server is the computer at the end of a browser's connection that knows how to answer your browser's requests for files/resources. Most web servers just send files, and that's actually the majority of traffic. But you're actually building a server in Ruby that knows how to take requests for resources and then return strings that you craft using Ruby. When you do this crafting, you are pretending to be a file to the browser, but really it's just code. As you can see from Exercise 50, it also doesn't take much code to create a response.

**Response**

This is the HTML (CSS, JavaScript, or images) your server wants to send back to the browser as the answer to the browser's request. In the case of files, it just reads them off the disk and sends them to the browser, but it wraps the contents of the disk in a special "header" so the browser knows what it's getting. In the case of your application, you're still sending the same thing, including the header, but you generate that data on the fly with your Ruby code.

#### Forms and Sinatra

/projects/gothonweb/bin/app.ruby :

```
require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
    return 'Hello world'
end

get '/hello/' do
    erb :hello_form
end

post '/hello/' do
    greeting = params[:greeting] || "Hi There"
    name = params[:name] || "Nobody"

    erb :index, :locals => {'greeting' => greeting, 'name' => name}
end
```
The views/index.erb file for the post '/hello/' handler to use:
```
<html>
    <head>
        <title>Gothons Of Planet Percal #25</title>
    </head>
<body>

<p>
I just wanted to say <em style="color: green; font-size: 2em;"><%= greeting %>, <%= name %></em>.
</p>

</body>
</html>
```

The web form:

views/hello_form.erb:

```
<html>
    <head>
        <title>Sample Web Form</title>
    </head>
<body>

<h1>Fill Out This Form</h1>

<form action="/hello/" method="POST">
    A Greeting: <input type="text" name="greeting">
    <br/>
    Your Name: <input type="text" name="name">
    <br/>
    <input type="submit">
</form>

</body>
</html>
```
    1. The <form> tag starts it off and says where to deliver this form. In this case it's to action="/hello/" which is our post '/hello/' handler, and method="POST" which tells the browser to use this mechanism.
    2. Text like you might put in another HTML tag, but also...
    3. <input> tags give the type of input fields we want, and the parameters to use. In this case we have two, one with name="greeting" for our params[:greeting] parameters, and name="name" for our params[:name] parameter.
    4. These parameters are then mapped in our post '/hello/' code to create the greeting and name variables which get passed as :locals to the erb :index call.
    5. Finally, the file views/index.erb gets these variables and it prints them.

#### Redacting using Templates

As programmers we have to find common patterns and try to automate them away. One common pattern is the HTML that is at the beginning and the end of each of our .erb files. You shouldn't have to type that every single time you want to create a new view, and you should be able to change that content in one place to change all the pages. The solution to this is a concept called a "layout template", which we'll create in views/layout.erb:

```
/layout.erb:

<html>
<head>
    <title>Gothons From Planet Percal #25</title>
</head>
<body>

<%= yield %>

</body>
</html>
```

This simply takes the common HTML at the top and bottom of every template and puts it into one file. The code <%= yield %> is a Ruby thing that says to stop there and run the other view then come back. By putting this into views/layout.erb we're telling Sinatra to "wrap" all of our templates with this HTML.

#### Automating Sinatra Tests 
You can also automate the testing of your web application using Rack::Test

***E.G***
tests/test_gothonweb.rb:

```
require './bin/app.rb'
require 'test/unit'
require 'rack/test'

class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_my_default
    get '/'
    assert_equal 'Hello world', last_response.body
  end

  def test_hello_form
    get '/hello/'
    assert last_response.ok?
    assert last_response.body.include?('A Greeting')
  end

  def test_hello_form_post
    post '/hello/', params={:name => 'Frank', :greeting => "Hi"}
    assert last_response.ok?
    assert last_response.body.include?('I just wanted to say')
  end
end
```
This file is simply pretending to be a web browser, and it looks similar to how the Sinatra handlers are, but written as if you were telling a browser to visit your webapplication with code. 

The test is run from the project base directory as follows:
```
rake test
```

#### Integrating Ruby into forms with Sinatra

WIthin the base app:
```
choices = {
    'HAM' => 'Hamburger',
    'PIZ' => 'Pizza',
    'CUR' => 'Curry',
    'NOO' => 'Noodles',
    }
```
Within the appropriate view:
```
<% choices.each do |id, text| %>
  <li>
    <label class='radio'>
      <input type='radio' name='vote' value='<%= id %>' id='vote_<%= id %>'><%= text %>
    </label>
  </li>
<% end %>
```
