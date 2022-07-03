# Adapter Pattern
# Date: 07-Apr-2022
# Authors:
#          A01376364 Alex Serrano Durán
#          A01377718 Javier Alexandro Vargas Sánchez

# File: queue_adapter.rb
# The source code contained in this file demonstrates how to
# implement the <em>adapter pattern</em>.

#This class models a QueueAdapter which adapts a FiFo queue into a LiFo queue or stack, inherits from the SimpleQueue class
class QueueAdapter < SimpleQueue

    #This method receives a queue and initializes the class
    def initialize(queue)
        @queue = queue
    end
    
    #This method receives an item and pushes it into our LiFo queue
    def push(item)
        @queue.insert(item)
        self
    end
    
    #This method checks whether or queue is empty or not, if not, then it will remove the top item on the queue and return it 
    def pop
        if @queue.empty?
            nil
        else
            for i in 0..size-2 do
                temp = @queue.remove
                @queue.insert(temp)
            end
            temp = @queue.remove
            temp
        end
    end
    
    #This method checks if our queue is empty
    def empty?
       @queue.empty?
    end
    
    #This method checks whether or queue is empty or not, if not, then it will check the top item on the queue and return it 
    def peek
        if @queue.empty? 
           nil
        else
            for i in 0..size-1 do
                temp = @queue.remove
                @queue.insert(temp)
            end
            temp
        end
    end
    
    #This method returns the length of our queue 
    def size 
        @queue.size
    end 
end