# Captcha provides a custom math capthca generator.
# Answers are encrypted using AES-128
class Captcha
  require 'ezcrypto'
  require 'linguistics'
  attr_accessor :lower_limit, :higher_limit
  
  # Initialize the class and set the lower and upper limits of the questions
  #
  # The lower limit is inclusive and the higher limit is exclusive.
  def initialize(lower_limit = 0, higher_limit = 10)
    @lower_limit = lower_limit
    @higher_limit = higher_limit
  end
  
  # Generate a question and answer pair as a hash
  #
  # Possible questions are:
  # * Additions
  # * Multiplications
  # * Subtractions
  #
  # Answers are always positive
  #
  # The answer is delivered in encrypted, base64 encoded form.
  def generate_qa(password, salt)
    key = EzCrypto::Key.with_password password, salt
    
    base_question = "What is "
    operators = ["+", "*", "-"]
    
    operands = [rand_range(lower_limit, higher_limit), rand_range(lower_limit, higher_limit)]
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
  
  # Check if a given answer is correct, returns a boolean
  #
  # To test the answer the following inputs are required:
  # * encrypted_answer - The encrypted answer from generate_qa
  # * attempt - The answer attempt from the user
  # * password - The password used when the question answer pair was created
  # * salt - The password used when the question answer pair was created
  def check_answer(encrypted_answer, attempt, password, salt)
    key = EzCrypto::Key.with_password password, salt
    
    return key.decrypt64(encrypted_answer) == attempt.to_s
  end
  
private
  
  # Convert a number to words using the Linguistics gem
  #
  # e.g. 2 to 'two'
  def number_to_word(number)
    Linguistics::use( :en )
    return number.en.numwords
  end
  
  # Find a random number withing an integer range
  #
  # Two inputs are required
  # * min - the lower limit (inclusive)
  # * max - the upper limit (exclusive)
  def rand_range(min, max)
    min + rand(max-min)
  end
end