class MathExpression
  private

    def get_char
      @look = @input.shift
    end

    def get_number
      value = 0
      nb_decimals = false
      expected('integer') if (!digit?(@look) && @look != '.')
      while (digit?(@look) || @look == '.')
        if @look == '.'
          match '.'
          if nb_decimals
            expected "integer"
          end
          nb_decimals = 1
        else
          if nb_decimals
            nb_decimals *= 10
            value = value + @look.to_f / nb_decimals
            get_char
            skip_white
          else
            value = 10 * value + @look.to_i
            get_char
            skip_white
          end
        end
      end
      value
    end

end
