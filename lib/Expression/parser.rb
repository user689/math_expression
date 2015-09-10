#!/usr/bin/env ruby -wKU

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

    def addop?(x)
      ['+', '-'].include? x
    end

    def get_char
      @look = @input.shift
    end

    def digit?(x)
      [*(0..9)].map(&:to_s).include?(x)
    end

    def alpha?(x)
      [*('a'..'z')].include? x.downcase
    end

    def match(char)
      if @look == char
        get_char
      else
        expected(char)
      end
    end

    def get_number
      value = 0
      expected('integer') if !digit?(@look)
      while digit?(@look)
        value = 10 * value + @look.to_i
        get_char
      end
      value
    end

    def get_name
      expected('alphabet') if !alpha?(@look)
      result = @look
      get_char
      result
    end

    def factor
      if @look == '('
        match('(')
        value = calculate
        match(')')
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

    def term
      value = factor
      while ['*', '/'].include? @look
        case @look
        when '*'
          match('*')
          value = value * factor
        when '/'
          match('/')
          value = value / factor
        end
      end
      value
    end

    def init
      @input = @input.split('') if @input.is_a? String
      get_char
    end
end
test = Expression.new("919-470").eval
puts test
