# Adapter Pattern
# Date: 07-Apr-2022
# Authors:
#          A01376364 Alex Serrano Durán
#          A01377718 Javier Alexandro Vargas Sánchez

# File: simple_queue.rb
# IMPORTANT: Do not modify the following class in any way!

#This class models a FiFo SimpleQueue
class SimpleQueue

  #This method initializes a SimpleQueue instance by creating and returning an empty array
  def initialize
    @info =[]
  end

  #This method inserts an item at the end of the queue
  def insert(x)
    @info.push(x)
    self
  end

  #This method removes the first item on the queue
  def remove
    if empty?
      raise "Can't remove if queue is empty"
    else
      @info.shift
    end
  end

  #This method checks if our queue is empty
  def empty?
    @info.empty?
  end

  #This method returns the size of our queue 
  def size
    @info.size
  end

  #This method inspects the queue and returns its content in the form of a string
  def inspect
    @info.inspect
  end

end