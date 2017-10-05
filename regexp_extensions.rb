# Load required extension scripts
# begin
#   require "string_extensions.rb"
# rescue
#   # recover by using path of current script as search path
#   require File.join(File.dirname(__FILE__),"string_extensions.rb")
# end

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

  ##
  # Returns array of all items matching regex in source string
  # @param [String] string The string to search
  # @param [Hash] options Optional arguments
  # @option options [Boolean] :index If true, result is hash with match positions as keys
  # @return [Array|Hash] Array or Hash of all matches, L-R order
  # @see match
  # @example
  #   /[a-c]+/.match_multiple("12abbc3bca4") => ["abbc", "bca"]
  # @example
  #   /[a-c]+/.match_multiple("12abbc3bca4",index: true) => 
  #       {2 => "abbc", 7 => "bca"}
  def match_multiple(string, options={})
    use_index = options.fetch(:index, false)
    matches=(use_index)? {} : []
    src_string=string.dup
    last_match=-1
    while !last_match.nil? do
      last_match = self.match(src_string)
      if !last_match.nil?
        match = last_match[0]
        if use_index
          index = string.index(match)
          matches[index] = match
        else
          matches.push(match)
        end
        src_string = src_string.gsub(match,"")
      end
    end
    matches
  end



end