#!/usr/bin/env ruby -wKU

%w(getters identifiers).each {|x| require_relative x }

class InvalidInput < Exception; end

class Expression
  def initialize(input, options = nil)
    @input = input
    @opt = options
    @look = nil
  end

  def eval
    init
    calculate
  end


  private

    def expected(msg)
      raise(InvalidInput, "\a#{msg} Expected")
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
      while  %w{! @ # $ % ^ &}.include? @look
        case @look
        when '^'
          match('^')
          value **= factor
        when '%'
          match '%'
          value = value % factor
        else
          raise InvalidInput, "Unexpected input"
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
            raise ZeroDivisionError,"Can't divide #{numerator} by zero"
          else
            value = numerator.to_f / denomenator
          end
        end
      end
      value
    end

    def init
      @input = @input.split('')
      get_char
      skip_white
    end
end
test = Expression.new("(2*3)@^2").eval
puts test
