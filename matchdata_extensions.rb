class MatchData
  ##
  # Produces a hash of capture groups
  # @param [Hash] options Optional parameter hash
  # @option options [Boolean] :symbols If true, convert group names to symbols in output; default false
  # @return {Hash} Hash using group names as keys and captures as values
  #
  def named_captures(options={})
    force_symbolic_names = options.fetch(:symbols, false)
    names = self.names
    capts = self.captures

    # Convert names to symbols if indicated
    names = names.map { |name| name.to_sym } if force_symbolic_names

    Hash[*names.zip(capts).flatten]
  end
end
