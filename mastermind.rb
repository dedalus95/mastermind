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

  def you_lost
    "The machine broke the code."
  end

  def new_game
    "Do you want to play again? Y/N"
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
  def human_create_code
    puts set_a_code
    code = gets.chomp
    return code
  end
end


class Maker
  include Display
  human_code = HumanCode.new
  HUMAN = human_code.human_create_code

  def set_computer_code 
    current_code = ComputerCode.new
    code = current_code.computer_create_code 
    puts code
    return code
  end

  def maker_game

   code = set_computer_code
    if code != HUMAN
      maker_game
    else
      puts you_lost
    end
  
  end

end



# li = Maker.new
# li.maker_game


class Breaker
  include Display
  computer_code = ComputerCode.new
  COMPUTER = computer_code.computer_create_code
  
  def maker_or_breaker
    puts break_or_make
    ans = gets.chomp.downcase
    if ans == 'breaker' 
     breaker_game 
    elsif
    ans == 'maker' 
    puts 'not available yet' 
    else
    puts unavailable
    maker_or_breaker
    end
  end


  def set_current_code
    puts set_sequence
    return current_code = gets.chomp
  end



  def breaker_game 
    current_code = set_current_code
    check_digits(COMPUTER, current_code)
    if !correct_sequence(current_code) 
      puts invalid_code
     breaker_game
    else
     if current_code != COMPUTER 
      breaker_game 
     else
      puts you_won
     end
    end
  end


  def correct_sequence(code)
    code.match?(/\b[1-6]{4}\b/)
  end


  def check_digits(secret, current)
    if current.length < 5
   a = (secret.split('') & current.split('')).flat_map {|n| [n] * [secret.split('').count(n), current.split('').count(n)].min}
    puts "You got #{a.length} digits right."

   b = secret.split('').zip(current.split(''))
   c = b.select {|em| em[0] == em[1]}
   puts "#{c.length} of them are in the right position."
    else return
    end
  end

end

lo = Breaker.new
lo.maker_or_breaker








