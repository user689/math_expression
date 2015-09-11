#!/usr/bin/env ruby -wKU
include Math
%w(getters identifiers).each {|x| require_relative x }

class InvalidInput < Exception; end

class Expression
  def initialize(input)
    @input = input
    @look = nil
  end

  def eval
    init
    calculate
  end


  private

    def expected(msg)
      raise(InvalidInput, "\a\"#{msg}\" Expected")
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
      elsif [*('a'..'z')].include? @look
        case @look
        when 'c'
          match_all('cos')
          case @look
          when 'h'
            match_all('h(')
            value = cosh(calculate)
          when '('
            match('(')
            value = cos(calculate)
          else
            expected('cos() or cosh()')
          end
        when 's'
          match_all('sin')
          case @look
          when 'h'
            match_all('h(')
            value = sinh(calculate)
          when '('
            match('(')
            value = sin(calculate)
          else
            expected('sin() or sinh()')
          end
        when 't'
          match_all('tan')
          case @look
          when 'h'
            match_all('h(')
            value = tanh(calculate)
          when '('
            match('(')
            value = tan(calculate)
          else
            expected('tan() or tanh()')
          end
        when 'a'
          match_all('arc')
          case @look
          when 'c'
            match_all('cos')
            case @look
            when 'h'
              match_all('h(')
              value = acosh(calculate)
            when '('
              match('(')
              value = acos(calculate)
            else
              expected('acos() or acosh()')
            end
          when 's'
            match_all('sin')
            case @look
            when 'h'
              match_all('h(')
              value = asinh(calculate)
            when '('
              match('(')
              value = asin(calculate)
            else
              expected('asin() or asinh()')
            end
          when 't'
            match_all('tan')
            case @look
            when 'h'
              match_all('h(')
              value = atanh(calculate)
            when '('
              match('(')
              value = atan(calculate)
            else
              expected('atan() or atanh()')
            end
          end
        else
          expected('function')
        end
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
          temp = value.downto(1).inject(:*)
          value = temp

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
      @input = @input.downcase.split('')
      get_char
      skip_white
    end
end
test = Expression.new(gets.chomp).eval
puts test
