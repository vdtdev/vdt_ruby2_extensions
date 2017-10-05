class String
  ##
  # "Affix" a string to the beginning or end of the source string
  # @param [String] fixture The fixture to use as pre or suffix
  # @param [Hash] options Optional parameters
  # @option options [String|Symbol] :position Position to attach fixture (:before, :after); default :after
  # @return [String] source string with fixture applied in specified location
  #
  def affix(fixture, options={})
    position = options.fetch(:position, "after").to_sym
    value = ((position == :before)? fixture : "") + 
      self + 
      ((position == :after)? fixture : "")
    value
  end

  ##
  # Execute gsub multiple times
  # @param [Array] replacements Array of gsub params [[match, replace], ...]
  # @return [String] String after gsub operations are performed
  # @see gsub
  #
  def gsubs(replacements)
    str = self.dup
    replacements.each do |r|
      str = str.gsub(r[0],r[1])
    end
    str
  end
end