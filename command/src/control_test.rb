# Command Pattern
# Date: 24-Mar-2022
# Authors:
#          A01376364 Alex Serrano Durán
#          A01377718 Javier Alexandro Vargas Sánchez

# File: control_test.rb

require 'minitest/autorun'
require 'stringio'
require './control'

#This class models a ControlTest and inherits from the Minitest::Test class
class ControlTest < Minitest::Test

  #This method sets the test up by calling the set_stdout method, creating a remote controller, calls the set_light and set_fan methods 
  def setup
    set_stdout
    @rc = RemoteControlWithUndo.new
    set_light
    set_fan
  end

  #This method tears down the active expected outputs set up in order to start a new test by calling the reset_stdout method
  def teardown
    reset_stdout
  end

  #This method sets up values to create expected outputs that will later be compared with actual outputs of the test
  def set_stdout
    @out = StringIO.new
    @old_stdout = $stdout
    $stdout = @out
  end
 
  #This method resets the active expected outputs 
  def reset_stdout
    $stdout = @old_stdout
  end

  #This method sets a Light configuration by creating a Light on a location, assigns the LightOnCommand and LightOffCommand to the new Light, and finally maps both to command to a button row on the remote controller
  def set_light
    light = Light.new("Living Room")
    light_on = LightOnCommand.new(light)
    light_off = LightOffCommand.new(light)
    @rc.set_command(0, light_on, light_off)
  end

  #This method sets a CeilingFan configuration by creating a CeilingFan on a location, assigns the CeilingFanMediumCommand, CeilingFanHighCommand and CeilingFanOffCommand to the new ceiling fan, and finally maps the commands to two button rows on the remote controller
  def set_fan
    fan = CeilingFan.new("Living Room")
    fan_medium = CeilingFanMediumCommand.new(fan)
    fan_high = CeilingFanHighCommand.new(fan)
    fan_off = CeilingFanOffCommand.new(fan)
    @rc.set_command(1, fan_medium, fan_off)
    @rc.set_command(2, fan_high, fan_off)
  end

  #This method tests the light is working properly on the remote controller
  def test_light
    @rc.on_button_was_pushed(0)
    @rc.off_button_was_pushed(0)
    p @rc
    @rc.undo_button_was_pushed
    @rc.off_button_was_pushed(0)
    @rc.on_button_was_pushed(0)
    p @rc
    @rc.undo_button_was_pushed
    assert_equal                                                \
      "Light is on\n"                                           \
      "Light is off\n"                                          \
      "\n------ Remote Control -------\n"                       \
      "[slot 0] LightOnCommand  LightOffCommand\n"              \
      "[slot 1] CeilingFanMediumCommand  CeilingFanOffCommand\n"\
      "[slot 2] CeilingFanHighCommand  CeilingFanOffCommand\n"  \
      "[slot 3] NoCommand  NoCommand\n"                         \
      "[slot 4] NoCommand  NoCommand\n"                         \
      "[slot 5] NoCommand  NoCommand\n"                         \
      "[slot 6] NoCommand  NoCommand\n"                         \
      "[undo] LightOffCommand\n\n"                              \
      "Light is on\n"                                           \
      "Light is off\n"                                          \
      "Light is on\n"                                           \
      "\n------ Remote Control -------\n"                       \
      "[slot 0] LightOnCommand  LightOffCommand\n"              \
      "[slot 1] CeilingFanMediumCommand  CeilingFanOffCommand\n"\
      "[slot 2] CeilingFanHighCommand  CeilingFanOffCommand\n"  \
      "[slot 3] NoCommand  NoCommand\n"                         \
      "[slot 4] NoCommand  NoCommand\n"                         \
      "[slot 5] NoCommand  NoCommand\n"                         \
      "[slot 6] NoCommand  NoCommand\n"                         \
      "[undo] LightOnCommand\n\n"                               \
      "Light is off\n", @out.string
  end

  #This method tests the ceiling fan is working properly on the remote controller
  def test_fan
    @rc.on_button_was_pushed(1)
    @rc.off_button_was_pushed(1)
    p @rc
    @rc.undo_button_was_pushed
    @rc.on_button_was_pushed(2)
    p @rc
    @rc.undo_button_was_pushed
    assert_equal                                                \
      "Living Room ceiling fan is on medium\n"                  \
      "Living Room ceiling fan is off\n"                        \
      "\n------ Remote Control -------\n"                       \
      "[slot 0] LightOnCommand  LightOffCommand\n"              \
      "[slot 1] CeilingFanMediumCommand  CeilingFanOffCommand\n"\
      "[slot 2] CeilingFanHighCommand  CeilingFanOffCommand\n"  \
      "[slot 3] NoCommand  NoCommand\n"                         \
      "[slot 4] NoCommand  NoCommand\n"                         \
      "[slot 5] NoCommand  NoCommand\n"                         \
      "[slot 6] NoCommand  NoCommand\n"                         \
      "[undo] CeilingFanOffCommand\n\n"                         \
      "Living Room ceiling fan is on medium\n"                  \
      "Living Room ceiling fan is on high\n"                    \
      "\n------ Remote Control -------\n"                       \
      "[slot 0] LightOnCommand  LightOffCommand\n"              \
      "[slot 1] CeilingFanMediumCommand  CeilingFanOffCommand\n"\
      "[slot 2] CeilingFanHighCommand  CeilingFanOffCommand\n"  \
      "[slot 3] NoCommand  NoCommand\n"                         \
      "[slot 4] NoCommand  NoCommand\n"                         \
      "[slot 5] NoCommand  NoCommand\n"                         \
      "[slot 6] NoCommand  NoCommand\n"                         \
      "[undo] CeilingFanHighCommand\n\n"                        \
      "Living Room ceiling fan is on medium\n", @out.string
  end

end