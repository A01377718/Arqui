# Domain-Specific Language Pattern
# Date: 28-Apr-2022
# Authors:
#          A01376364 Alex Serrano Durán
#          A01377718 Javier Alexandro Vargas Sánchez

# File: jankenpon.rb

#This method shows the result of a Jankenpon match
def show(result)
    puts "Result = #{result}"
end

#This class models a Rock option in the game Jankenpon
class Rock
    
    #This method receives an option and checks if this matchup results on a win for the Rock option or rather a win for other option
    def self.+(option)
        if(option == Scissors)
            puts "Rock crushes Scissors (winner Rock)"
            self
        elsif(option == Lizard)
            puts "Rock crushes Lizard (winner Rock)"
            self
        elsif(option == Rock)
            puts "Rock tie (winner Rock)"
            self
        else
            option + self
        end
    end
    
    
    #This method receives an option and checks if this matchup results on a loss for the Rock option or rather a win for the Rock
    def self.-(option)
        if(option == Paper)
            puts "Paper covers Rock (loser Rock)"
            self
        elsif(option == Spock)
            puts "Spock vaporizes Rock (loser Rock)"
            self
        elsif(option == Rock)
            puts "Rock tie (loser Rock)"
            self
        else
            option - self
        end
    end
end

#This class models a Paper option in the game Jankenpon
class Paper
    #This method receives an option and checks if this matchup results on a win for the Paper option or rather a win for other option
    def self.+(option)
        if(option == Rock)
            puts "Paper covers Rock (winner Paper)"
            self
        elsif(option == Spock)
            puts "Paper disproves Spock (winner Paper)"
            self
        elsif(option == Paper)
            puts "Paper tie (winner Paper)"
            self
        else
            option + self
        end
    end
    
    #This method receives an option and checks if this matchup results on a loss for the Paper option or rather a win for the Paper
    def self.-(option)
        if(option == Scissors)
            puts "Scissors cut Paper (loser Paper)"
            self
        elsif(option == Lizard)
            puts "Lizard eats Paper (loser Paper)"
            self
        elsif(option == Paper)
            puts "Paper tie (loser Paper)"
            self
        else
            (option - self)
        end
    end
end

#This class models a Scissors option in the game Jankenpon
class Scissors
    #This method receives an option and checks if this matchup results on a win for the Scissors option or rather a win for other option
    def self.+(option)
        if(option == Paper)
            puts "Scissors cut Paper (winner Scissors)"
            self
        elsif(option == Lizard)
            puts "Scissors decapitate Lizard (winner Scissors)"
            self
        elsif(option == Scissors)
            puts "Scissors tie (winner Scissors)"
            self
        else
            option + self
        end
    end
    
    #This method receives an option and checks if this matchup results on a loss for the Scissors option or rather a win for the Scissors
    def self.-(option)
        if(option == Rock)
            puts "Rock crushes Scissors (loser Scissors)"
            self
        elsif(option == Spock)
            puts "Spock smashes Scissors (loser Scissors)"
            self
        elsif(option == Scissors)
            puts "Scissors tie (loser Scissors)"
            self
        else
            option - self
        end
    end
end

#This class models a Lizard option in the game Jankenpon
class Lizard
    #This method receives an option and checks if this matchup results on a win for the Lizard option or rather a win for other option
    def self.+(option)
        if(option == Paper)
            puts "Lizard eats Paper (winner Lizard)"
            self
        elsif(option == Spock)
            puts "Lizard poisons Spock (winner Lizard)"
            self
        elsif(option == Lizard)
            puts "Lizard tie (winner Lizard)"
            self
        else
            option + self
        end
    end
    
    #This method receives an option and checks if this matchup results on a loss for the Lizard option or rather a win for the Lizard
    def self.-(option)
        if(option == Scissors)
            puts "Scissors decapitate Lizard (loser Lizard)"
            self
        elsif(option == Rock)
            puts "Rock crushes Lizard (loser Lizard)"
            self
        elsif(option == Lizard)
            puts "Lizard tie (loser Lizard)"
            self
        else
            option - self
        end
    end
end

#This class models a Spock option in the game Jankenpon
class Spock
    #This method receives an option and checks if this matchup results on a win for the Spock option or rather a win for other option
    def self.+(option)
        if(option == Scissors)
            puts "Spock smashes Scissors (winner Spock)"
            self
        elsif(option == Rock)
            puts "Spock vaporizes Rock (winner Spock)"
            self
        elsif(option == Spock)
            puts "Spock tie (winner Spock)"
            self
        else
            option + self
        end
    end
    
    #This method receives an option and checks if this matchup results on a loss for the Spock option or rather a win for Spock
    def self.-(option)
        if(option == Paper)
            puts "Paper disproves Spock (loser Spock)"
            self
        elsif(option == Lizard)
            puts "Lizard poisons Spock (loser Spock)"
            self
        elsif(option == Spock)
            puts "Spock tie (loser Spock)"
            self
        else
            option - self
        end
    end
end

