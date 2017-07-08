class Array

    ##
    # Return sum of numbers within array
    # @return [Number] sum of numbers within array
    # @example
    #   10 == [2,4,4].sum() => true
    def sum()
        value = 0
        self.each { |v| value += v }
        return value
    end
    
    ##
    # Return array containing absolute values of original
    # @return [Array] Array containing absolute values of original array
    def abs()
        self.map{ |v| v.abs }
    end

    ##
    # Return sum of absolute values of numbers within array
    # @return [Number] sum of absolute value of numbers in array
    # @example
    #   2 == [-1, 1].abs_sum => true
    # @see sum
    # @see abs
    def abs_sum()
        self.abs().sum()
    end

    ##
    # Return difference (a - b - c ... - z) of numbers in array
    # @return [Numeric] Result of subtracting all array values from first value
    def diff(options={})
        local = self.dup
        local = local.reverse if options.fetch(:ordered, false)
        value = local[0]
        local[1..-1].each { |v| value -= v }
        return value
    end

end