# A module to handle Arpabet phonetic encoded strings.
#
# It should be noted the parsing methods on this module do not validate if the
# phonemes and codes are Arpabet-compliant; rather, it has the main goal of
# extracting stress information from these strings.
module Datamuse::Arpabet
  # Parses a sequence of Arpabet phonemes.
  def self.parse(str : String) : Array(Phoneme)
    str.strip.split(' ').map { |phoneme| Phoneme.parse(phoneme) }
  end
end
