class Captcha
  require 'ezcrypto'
  
  def generate_qa(password, salt)
    key = EzCrypto::Key.with_password password, salt
    
    base_question = "What is "
    operators = ["+", "*", "-"]
    
    operands = [rand(10), rand(10)]
    operands.sort!
    
    case operators[rand(operators.length)]
      when "+"
        q = "#{base_question + number_to_word(operands[0])} plus #{number_to_word(operands[1])}?"
        a = operands[0] + operands[1]
      when "*"
        q = "#{base_question + number_to_word(operands[0])} times #{number_to_word(operands[1])}?"
        a = operands[0] * operands[1]
      when "-"
        q = "#{base_question + number_to_word(operands[1])} minus #{number_to_word(operands[0])}?"
        a = operands[1] - operands[0]
    end
    
    return {"question" => q, "encrypted_answer" => key.encrypt64(a.to_s).strip}
  end
  
  def check_answer(encrypted_answer, attempt, password, salt)
    key = EzCrypto::Key.with_password password, salt
    
    a = attempt.to_s
    
    if a.length > 1
      a = words_to_number(a).to_s
    end
    
    return key.decrypt64(encrypted_answer) == a
  end
  
private
  
  def number_to_word(number)
    numbers = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    
    n = number.to_i
    
    return numbers[n]
  end
  
  def words_to_number(word)
    numbers = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    
    return numbers.find_index(word.downcase)
  end
end