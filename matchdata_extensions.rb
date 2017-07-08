class MatchData
  ##
  # Produces a hash of capture groups
  # @return {Hash} Hash using group names as keys and captures as values
  #
  def named_captures()
    names = self.names
    capts = self.captures
    Hash[*names.zip(capts).flatten]
  end
end
