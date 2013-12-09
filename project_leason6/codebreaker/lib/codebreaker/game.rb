module Codebreaker
  class Game
    attr_reader :count_numbers, :max_number, :attempt, :max_attempt, :game_state, :hints 
    
    
    def initialize(count_numbers=4, max_number=6, max_attempt=4)
      @count_numbers, @max_number, @max_attempt = count_numbers, max_number, max_attempt
      restart
    end

    def restart
      @attempt = 0
      @hints = -1
      @game_state = :Continue
      generate
    end
    
    def guess code
      answer = ""
      if @game_state.eql?(:Continue)
        @attempt += 1      
        answer = get_answer_for code
        check_game_state_for answer      
        answer
      end      
    end
    
    def hint
      h = ""      
      @hints += 1 if @hints < @number.size-1
      0.upto(@hints) { |index| h += @number[index]}
      x_count = @number.size - h.size
      x_count.times { h+="X" }      
      h
    end
    
    private
    @number
    def generate
      @number = ""
      @count_numbers.times do
        @number << Random.rand(1..max_number).to_s 
      end
    end
    
    def check_game_state_for answer      
      @game_state = :Lose if @attempt == @max_attempt
      @game_state = :Win  if (check_answer_for answer)    
    end
    
    def check_answer_for answer
      answer.count("+") == @count_numbers
    end
    
    def get_answer_for code
      answer = ""
      code.each_char.with_index do |char, index|          
          if (@number.include?(char))
            answer += (@number[index] == char)? "+":"-"
          end
      end    
      answer = answer.chars.sort.join if answer.include?("-")
      answer
    end
  end
end
