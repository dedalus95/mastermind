module Display

  def break_or_make
    "Do you want to be the maker or the breaker? Input 'maker' or 'breaker'."
  end

  def unavailable
    require 'colorize'
    "Unavailable choice".red
  end

  def set_a_code
    "Write your secret code (4 digits between 1-6)."
  end

  def invalid_code
    require 'colorize'
    "Max 4 digits between 1-6".red
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

  def successful_machine
    "The machine broke the code."
  end

  def unsuccessful_machine
    "The machine didn't break the code."
  end

  def new_game
    "Do you want to play again? Y/N"
  end

end

module CorrectSequence 
  def correct_sequence(code)
    code.match?(/\b[1-6]{4}\b/)
  end
end

module CheckDigits 
  include Display
  def check_digits(secret, current)
    if current.length < 5
   a = (secret.split('') & current.split('')).flat_map {|n| [n] * [secret.split('').count(n), current.split('').count(n)].min}
    puts "The sequence contains #{a.length} digits right."

   b = secret.split('').zip(current.split(''))
   c = b.select {|em| em[0] == em[1]}
   puts "#{c.length} of them are in the right position."
   if a.length == 4 && c.length == 4
    return true
   end
    else 
      return
    end
  end
end


class ComputerCode
  
  def computer_create_code
    i = 4
    code = []
    until i == 0
    random = rand(1..6)
    code << random
    i -= 1
    end
    return code.join
  end
end

class HumanCode
  include Display
  include CorrectSequence
  def human_create_code
    puts set_a_code
    code = gets.chomp
    return code if correct_sequence(code)

    puts invalid_code
    human_create_code
  end
end


class Maker
  include Display
  include CheckDigits

  def set_human_code
    human_code = HumanCode.new
    human = human_code.human_create_code
    return human
  end

  def set_computer_code 
    computer = ComputerCode.new
    code = computer.computer_create_code
    puts code 
    return code
  end

  def maker_game
    i = 0
    human = set_human_code
    until i == 1200 || check_digits(human, set_computer_code)
      puts "Attempt n. #{i + 1}"
      i += 1
    end
    if i < 1200
    puts successful_machine 
    else
    puts unsuccessful_machine
    end
  end

end



class Breaker
  include Display
  include CorrectSequence
  include CheckDigits
  computer_code = ComputerCode.new
  COMPUTER = computer_code.computer_create_code
  

  def set_current_code
    puts set_sequence
    return current_code = gets.chomp
  end

  def breaker_game 
    current_code = set_current_code
    if !correct_sequence(current_code) 
     puts invalid_code
     breaker_game
    else
     if !check_digits(COMPUTER, current_code) 
     breaker_game 
     else
     puts you_won
     end
    end
  end
end





class Play
  include Display

    def maker_or_breaker
      puts break_or_make
      ans = gets.chomp.downcase
      if ans == 'breaker' 
        li = Breaker.new
        li.breaker_game
      elsif ans == 'maker' 
      lo = Maker.new
      lo.maker_game 
      else
      puts unavailable
      maker_or_breaker
      end
    end
end


  dim = Play.new
  dim.maker_or_breaker







