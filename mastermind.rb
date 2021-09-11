module Display

  def break_or_make
    "Do you want to be the maker or the breaker? Input 'maker' or 'breaker'."
  end

  def set_a_code
    "Write your code (4 digits between 1-6)."
  end

  def invalid_code
    "Max 4 digits between 1-6"
  end

  def set_sequence
    "Write your guess (4 digits between 1-6)."
  end

  def current_turn(number)
    "Turn #{number}"
  end

  def you_won
    "You broke the code."
  end

  def you_lost
    "You didn't succeed."
  end

  def new_game
    "Do you want to play again? Y/N"
  end

end


class SecretCode 
  attr_reader :code
  def initialize(code)
    @code = code
  end
end

class CurrentCode
  attr_reader :code
  def initialize(code)
    @code = code
  end
end


class Game
  include Display
  
  def set_secret_code()
    puts set_a_code
    code = gets.chomp.to_s
    return SecretCode.new(code) if correct_sequence(code)

    puts invalid_code
    set_secret_code
  end

  def set_current_code
    puts set_sequence
    code = gets.chomp.to_s
    return CurrentCode.new(code) if correct_sequence(code)

    puts invalid_code
    set_current_code
  end

  def correct_sequence(code)
    code.match?(/\b[1-6]{4}\b/)
  end

  def codes
    secret_code = set_secret_code
    current_code = set_current_code
    until secret_code.code == current_code.code
      set_current_code
    end
  end

  def computer_generate_code
    i = 4
    arr = []
    until i == 0
    random = rand(1..6)
    arr << random
    i -= 1
    end
    return arr.join
  end

end

lo = Game.new

lo.codes


