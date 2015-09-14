#!/usr/bin/env ruby -wKU
include Math
%w(getters identifiers).each {|x| require_relative x }

class InvalidInput < Exception; end
class IndeterminedForm < Exception; end

class MathExpression
  def initialize()
    @input = nil
    @look = nil
  end

  def eval(input)
    @input = input
    init
    temp = calculate
    unless @look.nil?
      raise InvalidInput, "unexpected input: \"#{@look}\""
    end
    temp
  end


  private

    def expected(msg)
      raise InvalidInput, "\a\"#{msg}\" expected"
    end

    def factor

      if @look == '('
        match('(')
        value = calculate
        match(')')
      elsif @look == '['
        match('[')
        value = calculate
        match(']')
      elsif alpha? @look
        value = trig
      else
        value = get_number
      end
      value
    end

    def calculate
      if addop? @look
        value = 0
      else
        value = term
      end
      while addop?(@look)
        case @look
        when '+'
          match('+')
          value += term
        when '-'
          match('-')
          value -= term
        end
      end
      value
    end

    def ident
      value = factor
      while  %w{! % ^}.include? @look
        case @look
        when '^'
          match('^')
          value **= factor
        when '%'
          match '%'
          value = value % factor
        when '!'
          match('!')
          str = value.to_s.split(".")
          if str[1] == "0" || str.size == 1
            temp = (1..value).reduce(1, :*)
            value = temp
          else
            raise InvalidInput, "Factorial is not defined for floats"
          end
        end
      end
      value
    end

    def term
      value = ident
      while ['*', '/'].include? @look
        case @look
        when '*'
          match('*')
          value *= ident
        when '/'
          match('/')
          numerator = value
          denomenator = ident
          if denomenator == 0
            raise IndeterminedForm, "Division by zero is undefined"
          else
            value = numerator.to_f / denomenator
          end
        end
      end
      value
    end

    def init
      @input = @input.downcase.split('')
      get_char
      skip_white
    end
end

# puts MathExpression.new().eval(gets)
