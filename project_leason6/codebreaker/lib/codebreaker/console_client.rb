$LOAD_PATH << File.dirname(__FILE__)
require 'game'
require 'validator_code'

module Codebreaker
  class ConsoleCodebraker
    attr_reader :description                
    
    def initialize game, validator_code      
      @game, @validator_code = game, validator_code      
      @description = <<-DESC
      Codebreaker is a logic game in which a code-breaker tries to break a secret code created by a code-maker. The code-maker, which will be played by the application we’re going to write, creates a secret code of four numbers between 1 and 6.

The code-breaker then gets some number of chances to break the code. In each turn, the code-breaker makes a try_guess of four numbers. The code-maker then marks the try_guess with up to four + and - signs.

A + indicates an exact match: one of the numbers in the try_guess is the same as one of the numbers in the secret code and in the same position.

A - indicates a number match: one of the numbers in the try_guess is the same as one of the numbers in the secret code but in a different position.

// Also, u can get a hint, just press 'h'
                        DESC            
      puts "Welcome to Codebreaker!"
      puts @description     
    end
     
    def restart
      @time_start = Time.now
      @game.restart
    end
    
    def guess command
      command = command.chomp
      case command
        when "h"
          puts hint
        else
          try_guess command
      end
    end  
    
    def game_state
      @game.game_state
    end
    
    def hint
      return @game.hint
    end    
    
    def save_score      
      begin
        @time_end = Time.now
        print "What is u\'r name? "
        name = gets      
        file_path = "scores/score_["+@time_end.day.to_s+"."+@time_end.month.to_s+"."+@time_end.year.to_s+"].txt"
        file = File.open(file_path, "a")
        file.write("\nPlayer #{name} started at #{@time_start} is #{@game.game_state.upcase} on #{@time_end} used #{@game.attempt} attempts and #{@game.hints} hints") 
      rescue IOError => e
        p "**Error** occur, dir not writable etc. Game results is not saved! "
      ensure
        file.close unless file == nil
      end      
      p "Game results is saved!"      
    end
    
    def play_again?
      print "Do u whant play again(y/n)?: "
      answer = gets
      return answer[0].upcase=='Y'        
    end        
    
    private    
    def try_guess code      
      if @validator_code.valid?(code)
        puts @game.guess code
        check_game_state
      else
        puts "**ERROR** Invalid code format:"
        puts @validator_code.failure_message
      end
    end
    
    def check_game_state      
      case @game.game_state
        when :Lose then
          secret_code = get_number @game
          puts "Sorry, but u lose!!! Codebreaker win it now with code: "+secret_code.to_s
        when :Win then
          secret_code = get_number @game
          puts "Congratulations!!! U break the secret code!"  
        else
          puts attempts_left.to_s+" attempts left"   
      end        
    end        
    
    def attempts_left
      @game.max_attempt-@game.attempt  
    end
    
    def get_number game
      number = ""
      @game.count_numbers.times{ number += @game.hint }
      number = number.match(/[1-6]{4}/).to_s
    end        
        
  end #class ends
  
  
  #game logic
  #GAME DIFFICULTY CONSTANTS
  GUESS_SIZE = 4
  MAX_GUESS_NUM = 6
  MAX_ATTEMPT = 4
  #init
  game = Game.new 
  validator = CodeValidator.new GUESS_SIZE, MAX_GUESS_NUM
  console_client = ConsoleCodebraker.new game, validator
  #start
  loop do
    console_client.restart
    while console_client.game_state == :Continue  
      puts "Enter u\'r guess: "
      console_client.guess gets
    end
    console_client.save_score
    break unless console_client.play_again?
  end
  puts "Bye. Good luck;)"
end
