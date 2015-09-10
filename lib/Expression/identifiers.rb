class Expression
  private

    def addop?(x)
      ['+', '-'].include? x
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
        skip_white
      else
        expected(char)
      end
    end

    def skip_white
      while @look =~ /\s/
        get_char
      end
    end

end
