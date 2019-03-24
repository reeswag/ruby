## Animal is-a Object / Specifically is an object of the super-class Class
class Animal
end

## Dog is-a animal
class Dog < Animal

  def initialize(name)
    ## Dog has-a name
    @name = name
  end
end

## Cat is-a Animal
class Cat < Animal

  def initialize(name)
    ## Cat has-a name
    @name = name
  end
end

## Person is-a Object / Specifically is an object of the super-class Class
class Person

  def initialize(name)
    ## Person has-a name
    @name = name

    ## Person has-a pet of some kind
    @pet = nil
  end

  attr_accessor :pet
end

## Employee is-a Person
class Employee < Person

  def initialize(name, salary)
    ## When super is invoked, ruby sends a message to the parent of the Employee object, in this case the super-class Person, to check for a method initialize and run it with the attribute name. This is useful as it means we can work from the bottom upwards and create an object which passess the relavant info to it's 'parents'. 
    super(name)
    ## Employee has-a salary 
    @salary = salary
  end

end

## Fish is-a Object
class Fish
end

## Salmon is-a Fish
class Salmon < Fish
end

## Halibut is-a Fish
class Halibut < Fish
end


## rover is-a Dog
rover = Dog.new("Rover")

## satan is-a Cat
satan = Cat.new("Satan")

## mary is-a Person
mary = Person.new("Mary")

## mary has-a pet, satan.
mary.pet = satan

## frank is-a Employee and has-a salary of 120000
frank = Employee.new("Frank", 120000)

## frank has-a pet, rover
frank.pet = rover

## flipper is-a Fish
flipper = Fish.new()

## crouse is-a Salmon
crouse = Salmon.new()

## harry is-a Halibut 
harry = Halibut.new()