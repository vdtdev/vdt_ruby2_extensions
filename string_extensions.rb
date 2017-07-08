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
end