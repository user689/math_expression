class Expression
  private

    def get_char
      @look = @input.shift
    end

    def get_number
      value = 0
      expected('integer') if !digit?(@look)
      while digit?(@look)
        value = 10 * value + @look.to_i
        get_char
        skip_white
      end
      value
    end

    def get_name
      expected('alphabet') if !alpha?(@look)
      result = @look
      get_char
      result
    end

end
