class Expression
  private

    def addop?(x)
      ['+', '-'].include? x
    end

    def digit?(x)
      [*(0..9)].map(&:to_s).include?(x)
    end

    def alpha?(x)
      [*('a'..'z')].include? x
    end

    def match(char)
      if @look == char
        get_char
        skip_white
      else
        expected(char)
      end
    end

    def match_all(string)
      string.each_char { |x| match(x) }
    end

    def skip_white
      while @look =~ /\s/
        get_char
      end
    end
    def trig
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
        match('s')
        if @look == 'q'
          match_all('qrt(')
          value = sqrt(calculate)
        else
          match_all('in')
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
        end
      when 'r'
        match_all('root')
        base = get_number
        match('(')
        value = calculate ** (1.0/base)
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
      when 'l'
        match('l')
        case @look
        when 'n'
          match_all('n(')
          value = log(calculate)
        when 'o'
          match_all('og')
          base = get_number
          match('(')
          value = log(calculate, base)
        else
          expected('ln() or log()')
        end
      when 'e'
        match_all('exp(')
        value = exp(calculate)
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
            expected('arccos() or arccosh()')
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
            expected('arcsin() or arcsinh()')
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
            expected('arctan() or arctanh()')
          end
        end
      else
        raise InvalidInput, "unexpected input: \"#{@look}\""
      end
      match(')')
      value
    end

end
