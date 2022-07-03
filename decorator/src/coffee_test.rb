# Decorator Pattern
# Date: 21-Apr-2022
# Authors:
#          A01376364 Alex Serrano Durán
#          A01377718 Javier Alexandro Vargas Sánchez
# File: coffee_test.rb

require 'minitest/autorun'
require './coffee'

#This class models a CoffeeTest which inherits from the Minitest::Test class and will check the file coffee.rb in order to check it works properly
class CoffeeTest < Minitest::Test

#This method checks the functionality in the Espresso class
  def test_espresso
    beverage = Espresso.new
    assert_equal("Espresso", beverage.description)
    assert_equal(1.99, beverage.cost)
  end

  #This method checks the functionality in the DarkRoast class aswell as various condiments (Milk, Mocha, Whip)
  def test_dark_roast
    beverage = DarkRoast.new
    beverage = Milk.new(beverage)
    beverage = Mocha.new(beverage)
    beverage = Mocha.new(beverage)
    beverage = Whip.new(beverage)
    assert_equal("Dark Roast Coffee, Milk, Mocha, Mocha, Whip",
                 beverage.description)
    assert_equal(1.59, beverage.cost)
  end

  #This method checks the functionality in the HouseBlend class aswell as various condiments (Soy, Mocha, Whip)
  def test_house_blend
    beverage = HouseBlend.new
    beverage = Soy.new(beverage)
    beverage = Mocha.new(beverage)
    beverage = Whip.new(beverage)
    assert_equal("House Blend Coffee, Soy, Mocha, Whip",
                 beverage.description)
    assert_equal(1.34, beverage.cost)
  end

end