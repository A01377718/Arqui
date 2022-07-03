# Command Pattern
# Date: 24-Mar-2022
# Authors:
#          A01376364 Alex Serrano Durán
#          A01377718 Javier Alexandro Vargas Sánchez

# File: control.rb
# The source code contained in this file demonstrates how to
# implement the <em>command pattern</em>.

#This class models a remote controller with an undo button
class RemoteControlWithUndo

  #This method initializes a remote controller instance with seven rows each containg 2 buttons, and an undo button at the end
  def initialize
    @on_commands = []
    @off_commands = []
    no_command = NoCommand.new
    7.times do
      @on_commands << no_command
      @off_commands << no_command
    end
    @undo_command = no_command
  end

  #This method method receives a slot, an on command and off command, it maps both commands to the given button slot
  def set_command(slot, on_command, off_command)
    @on_commands[slot] = on_command
    @off_commands[slot] = off_command
  end

  #This method receives a slot executes the on command in the given row and registers the push on the undo button
  def on_button_was_pushed(slot)
    @on_commands[slot].execute
    @undo_command = @on_commands[slot]
  end

  #This method receives a slot and executes the off command in the given row and registers the push on the undo button
  def off_button_was_pushed(slot)
    @off_commands[slot].execute
    @undo_command = @off_commands[slot]
  end

  #This method calls the undo method
  def undo_button_was_pushed()
    @undo_command.undo
  end
  
  #This method inspects each row of the controller and returns what each button has been set to do
  def inspect
    string_buff = ["\n------ Remote Control -------\n"]
    @on_commands.zip(@off_commands) \
        .each_with_index do |commands, i|
      on_command, off_command = commands
      string_buff << \
      "[slot #{i}] #{on_command.class}  " \
        "#{off_command.class}\n"
    end
    string_buff << "[undo] #{@undo_command.class}\n"
    string_buff.join
  end

end

#This class models a No Command button 
class NoCommand

  #Since this button has not been set up to do a command, this method does nothing
  def execute
  end

  #Since this button has not been set up to do a command, this method does nothing 
  def undo
  end

end

#This class models a light
class Light

  attr_reader :level

  #This method receives a location and initializes a Light class in the given location and a level of brightness set to zero by default
  def initialize(location)
    @location = location
    @level = 0
  end

  #This method turns the light on by setting its level to 100
  def on
    @level = 100
    puts "Light is on"
  end

  #This method turns the light off by setting its level to 0
  def off
    @level = 0
    puts "Light is off"
  end

  #This method receives a level of brightness and dims the light to that level
  def dim(level)
    @level = level
    if level == 0
      off
    else
      puts "Light is dimmed to #{@level}%"
    end
  end

end

#This class models a ceiling fan
class CeilingFan

  # Access these constants from outside this class as
  # CeilingFan::HIGH, CeilingFan::MEDIUM, and so on.
  HIGH   = 3
  MEDIUM = 2
  LOW    = 1
  OFF    = 0

  attr_reader :speed

  #This method receives a location and initializes a CeilingFan class in the given location and a speed level set to zero by default
  def initialize(location)
    @location = location
    @speed = OFF
  end

  #This method sets the CeilingFan speed to high
  def high
    @speed = HIGH
    puts "#{@location} ceiling fan is on high"
  end

  #This method sets the CeilingFan speed to medium
  def medium
    @speed = MEDIUM
    puts "#{@location} ceiling fan is on medium"
  end

  #This method sets the CeilingFan speed to low
  def low
    @speed = LOW
    puts "#{@location} ceiling fan is on low"
  end

  #This method sets the CeilingFan off
  def off
    @speed = OFF
    puts "#{@location} ceiling fan is off"
  end

end

#This subclass models a LightOnCommand mapped to a button on the remote controller it inherits from class Light
class LightOnCommand < Light
  
  #This method receives a light and initializes the LightOnCommand class
  def initialize(light)
    @light = light
  end
  
  #This method executes the LighOnCommand which calls the on method
  def execute
    @light.on
  end
  
  #This method executes the undo button by calling the off method
  def undo
    @light.off
  end
  
end

#This subclass models a LightOffCommand mapped to a button on the remote controller it inherits from class Light
class LightOffCommand < Light
  
  #This method receives a light and initializes the LightOffCommand class
  def initialize(light)
    @light = light
  end
  
  #This method executes the LighOffCommand which calls the off method
  def execute
    @light.off
  end
  
  #This method executes the undo button by calling the on method
  def undo
    @light.on
  end
  
end

#This subclass models a CeilingFanHighCommand mapped to a button on the remote controller it inherits from class CeilingFan
class CeilingFanHighCommand < CeilingFan
  
  #This method receives a fan, initializes the CeilingFanHighCommand class and a previousSpeed attribute with no initial value
  def initialize(fan)
    @fan = fan
    @previousSpeed
  end
  
  #This method executes the CeilingFanHighCommand which stores the previous speed of the fan and sets its new speed to high
  def execute
    @previousSpeed = @fan.speed
    @fan.high
  end
  
  #This method undoes the last command, it will check which was the fan's previous speed and set it up to it
  def undo
    if @previousSpeed == 3
      @fan.high
    elsif @previousSpeed == 2
      @fan.medium
    elsif @previousSpeed == 1
      @fan.low
    elsif @previousSpeed == 0
      @fan.off
    end
  end
  
end

#This subclass models a CeilingFanMediumCommand mapped to a button on the remote controller it inherits from class CeilingFan
class CeilingFanMediumCommand < CeilingFan
  
  #This method receives a fan, initializes the CeilingFanMediumCommand class and a previousSpeed attribute with no initial value
  def initialize(fan)
    @fan = fan
    @previousSpeed
  end
  
  #This method executes the CeilingFanMediumCommand which stores the previous speed of the fan and sets its new speed to medium
  def execute
    @previousSpeed = @fan.speed
    @fan.medium
  end
  
  #This method undoes the last command, it will check which was the fan's previous speed and set it up to it
  def undo
    if @previousSpeed == 3
      @fan.high
    elsif @previousSpeed == 2
      @fan.medium
    elsif @previousSpeed == 1
      @fan.low
    elsif @previousSpeed == 0
      @fan.off
    end
  end
  
end

#This subclass models a CeilingFanOffCommand mapped to a button on the remote controller it inherits from class CeilingFan
class CeilingFanOffCommand < CeilingFan
  
  #This method receives a fan, initializes the CeilingFanOffCommand class and a previousSpeed attribute with no initial value
  def initialize(fan)
    @fan = fan
    @previousSpeed
  end
  
  #This method executes the CeilingFanOffCommand which stores the previous speed of the fan and turns the fan off
  def execute
    @previousSpeed = @fan.speed
    @fan.off
  end
  
  #This method undoes the last command, it will check which was the fan's previous speed and set it up to it
  def undo
    if @previousSpeed == 3
      @fan.high
    elsif @previousSpeed == 2
      @fan.medium
    elsif @previousSpeed == 1
      @fan.low
    elsif @previousSpeed == 0
      @fan.off
    end
  end
  
end