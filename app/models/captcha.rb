class Captcha
  require 'ezcrypto'
  
  NUMBERS = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
  
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
    
    answer = attempt.to_s
    
    if answer.length > 1
      answer = words_to_number(answer).to_s
    end
    
    return key.decrypt64(encrypted_answer) == answer
  end
  
private
  
  def number_to_word(number)
    return NUMBERS[number.to_i]
  end
  
  def words_to_number(word)
    return NUMBERS.find_index(word.downcase)
  end
end