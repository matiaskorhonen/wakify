# Captcha provides a custom math capthca generator.
# Answers are encrypted using AES-128
class Captcha
  require 'linguistics'
  require 'digest'
  attr_accessor :lower_limit, :upper_limit, :salt
  
  # Initialize the class and set the lower and upper limits of the questions
  #
  # The lower limit is inclusive and the upper limit is exclusive.
  def initialize(salt, lower_limit = 0, upper_limit = 10)
    @lower_limit = lower_limit
    @upper_limit = upper_limit
    @salt = salt
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
  # The answer is delivered salted and hashed (SHA-256)
  def generate_qa
    base_question = "What is "
    operators = ["+", "*", "-"]
    
    operands = [rand_range(lower_limit, upper_limit), rand_range(lower_limit, upper_limit)]
    
    case operators[rand(operators.length)]
      when "+"
        q = "#{base_question + number_to_word(operands.first)} plus #{number_to_word(operands.last)}?"
        a = operands.first + operands.last
      when "*"
        q = "#{base_question + number_to_word(operands.first)} times #{number_to_word(operands.last)}?"
        a = operands.first * operands.last
      when "-"
        q = "#{base_question + number_to_word(operands.max)} minus #{number_to_word(operands.min)}?"
        a = operands.max - operands.min
    end
    
    return {:question => q, :hashed_answer => hash_answer(a)}
  end
  
  # Check if a given answer is correct, returns a boolean
  #
  # To test the answer the following inputs are required:
  # * <tt>hashed_answer</tt> - The encrypted answer from generate_qa
  # * <tt>attempt</tt> - The answer attempt from the user
  def check_answer(hashed_answer, attempt)
    return hashed_answer == hash_answer(attempt)
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
  
  # Generate the SHA-256 answer hash
  def hash_answer(answer)
    Digest::SHA2.hexdigest([answer.to_s, salt].join)
  end
end