#!/usr/bin/env ruby -wKU

class InvalidInput < Exception; end

class Expression
  def initialize(input, options = nil)
    @input = input
    @opt = options
    @look = nil
  end
  public

  def calculate
    init
    if addop? @look
      value = 0
    else
      value = get_number
    end
    while addop?(@look)
      case @look
      when '+'
        match('+')
        value += get_number
      when '-'
        match('-')
        value -= get_number
      end
    end
    value
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
      expected('integer') if !digit?(@look)
      result = @look.to_i
      get_char
      result
    end

    def get_name
      expected('alphabet') if !alpha?(@look)
      result = @look
      get_char
      result
    end

    def init
      @input = @input.split('')
      get_char
    end
end
test = Expression.new("2+3").calculate
puts test
