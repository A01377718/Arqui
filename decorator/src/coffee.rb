# Decorator Pattern
# Date: 21-Apr-2022
# Authors:
#          A01376364 Alex Serrano Durán
#          A01377718 Javier Alexandro Vargas Sánchez

# File: coffee.rb

#Thi class models a Beverage 
class Beverage
    
    #This method initializes a Beverage instance with a description
    def initialize()
        @desc = "Beverage"
    end
    #This method returns a description
    def description()
        @desc
    end 
    
end 

#This class models a Condiment Decorator class which inherits form the Beverage class and will be a super class for condiments
class CondimentDecorator < Beverage
    
    #This method initializes a CondimentDecorator instance with a description
    def initialize()
        @desc = "Condiment"
    end 
    
    #This method returns a description
    def description()
        @desc
    end
end

#This class models a DarkRoast coffee which inherits from the Beverage class
class DarkRoast < Beverage
    
    #This method initializes a DarkRoast coffee instance with a description and a price
    def initialize()
        @desc = "Dark Roast Coffee"
        @price = 0.99
    end
    
    #This method returns the price of a DarkRoast coffee
    def cost()
        @price
    end
    
end     

#This class models an Espresso coffee which inherits from the Beverage class
class Espresso < Beverage
    
    #This method initializes an Espresso coffee instance with a description and a price
    def initialize()
        @desc = "Espresso"
        @price = 1.99
    end
    
    #This method returns the price of an Espresso coffee
    def cost()
        @price
    end
    
end  

#This class models a HouseBlend coffee which inherits from the Beverage class
class HouseBlend < Beverage
    
    #This method initializes a HouseBlend coffee instance with a description and a price
    def initialize()
        @desc = "House Blend Coffee"
        @price = 0.89
    end
    
    #This method returns the price of a HouseBlend coffee
    def cost()
        @price
    end
    
end  

#This class models a Mocha condiment which inherits from the CondimentDecorator class
class Mocha < CondimentDecorator
    
    #This method initializes a Mocha condiment instance with a description and a price
    def initialize(beverage)
        @beverage = beverage
        @desc = ", Mocha"
        @price = 0.20
    end
    
    #This method concatenates the description of the Mocha condiment with the description of the Beverage it has been added to and returns this string
    def description()
        @beverage.description + @desc
    end
    
    #This method adds the price of the Mocha condiment to the Beverage it has been added to and returns the total
    def cost()
        @beverage.cost + @price
    end
end 

#This class models a Whip condiment which inherits from the CondimentDecorator class
class Whip < CondimentDecorator
    
    #This method initializes a Whip condiment instance with a description and a price
    def initialize(beverage)
        @beverage = beverage
        @desc = ", Whip"
        @price = 0.10
    end
    
    #This method concatenates the description of the Whip condiment with the description of the Beverage it has been added to and returns this string
    def description()
        @beverage.description + @desc
    end
    
    #This method adds the price of the Whip condiment to the Beverage it has been added to and returns the total
    def cost()
        @beverage.cost + @price
    end
end 

#This class models a Milk condiment which inherits from the CondimentDecorator class
class Milk < CondimentDecorator
    
    #This method initializes a Milk condiment instance with a description and a price
    def initialize(beverage)
        @beverage = beverage
        @desc = ", Milk"
        @price = 0.10
    end
    
    #This method concatenates the description of the Milk condiment with the description of the Beverage it has been added to and returns this string
    def description()
        @beverage.description + @desc
    end
    
    #This method adds the price of the Milk condiment to the Beverage it has been added to and returns the total
    def cost()
        @beverage.cost + @price
    end
end 

#This class models a Soy condiment which inherits from the CondimentDecorator class
class Soy < CondimentDecorator
    
    #This method initializes a Soy condiment instance with a description and a price
    def initialize(beverage)
        @beverage = beverage
        @desc = ", Soy"
        @price = 0.15
    end
    
    #This method concatenates the description of the Soy condiment with the description of the Beverage it has been added to and returns this string
    def description()
        @beverage.description + @desc
    end
    
    #This method adds the price of the Soy condiment to the Beverage it has been added to and returns the total
    def cost()
        @beverage.cost + @price
    end
end 