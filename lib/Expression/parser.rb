#!/usr/bin/env ruby -wKU

class InvalidInput < Exception; end

class Expression
  def initialize(input, options)
    @input = input
    @opt = options
    @look = nil
  end
  public

  def calculate
    init
  end


  private

    def expected(msg)
      raise(InvalidInput, "\a#{msg} Expected")
    end

    def get_char
      @look = @input.shift
    end

    def digit?(x)
      [*(0..9)].map(&:to_s).include?(x)
    end

    def match(char)
      if @look == char
        get_char
      else
        expected(char)
      end
    end

    def init
      @input = @input.split('')
      get_char
    end
end
test = Expression.new("2+3","@!3").calculate
