class Captcha
  require 'ezcrypto'
  require 'linguistics'

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
    
    return key.decrypt64(encrypted_answer) == attempt.to_s
  end
  
private
  
  def number_to_word(number)
    Linguistics::use( :en )
    return number.en.numwords
  end
end