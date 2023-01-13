module Datamuse
  # All the parts of speech supported by the Datamuse API.
  enum PartOfSpeech
    Noun
    Verb
    Adjective
    Adverb
    Undefined
  end

  # A converter for `PartOfSpeech` and `String` values.
  module PartOfSpeechConverter
    # Converts a string to a `PartOfSpeech` value.
    def self.from_s(str : String) : PartOfSpeech?
      case str
        when "n"   then PartOfSpeech::Noun
        when "v"   then PartOfSpeech::Verb
        when "adj" then PartOfSpeech::Adjective
        when "adv" then PartOfSpeech::Adverb
        when "u"   then PartOfSpeech::Undefined
        else            nil
      end
    end
  end
end
