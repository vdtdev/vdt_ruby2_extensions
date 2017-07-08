load "string_extensions.rb"

class Regexp

  ##
  # Find multiple matches in a string by dividing it using a split string
  # @param [String] text The text to perform regex match on
  # @param [String] split The string to use when performing split operation on text
  # @param [Hash] options Optional parameter hash
  # @option options [String|Symbol] :position Position to rejoin split string (:before, :after, :none); default :after
  # @option options [Boolean] :rejoin Whether to rejoin split text; true by default unless :position is :none
  # @option options [String] :split_text Optional override of text to use when rejoining; defaults to split param value
  # @return [Array] array containing all match MatchData objects
  # @see MatchData
  # @see match
  def match_all(text, split, options={})

    # Process optional params, falling back on defaults
    split_text = options.fetch(:split_text, split)

    join = {
      position: options.fetch(:position, "after").to_sym
    }
    join[:enabled] = options.fetch(:rejoin,
      (join[:position] == :none)? false : true
    )

    # Split source text
    parts = text.split(split)

    # If indicated, add text removed by split back into source text
    if join[:enabled]
      parts = parts.map do |part|
        part.affix(split_text, position: join[:position])
      end
    end

    matches = []

    # Perform match calls on each split part
    parts.each do |part|
      matches << self.match(part)
    end

    matches
  end
end