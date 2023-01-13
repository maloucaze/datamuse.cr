module Datamuse
  # All the possible vocabularies that can be used with Datamuse.
  enum Vocabulary
    # Datamuse's standard 550,000-term vocabulary of English words.
    Standard

    # Datamuse's Spanish vocabulary.
    Spanish

    # Wikipedia's English vocabulary.
    EnglishWikipedia
  end

  # A converter for `Vocabulary` and `String` values.
  module VocabularyConverter
    # Converts a string into a `Vocabulary`.
    def self.from_s(str : String) : Vocabulary?
      case str
        when "es"     then Vocabulary::Spanish
        when "enwiki" then Vocabulary::EnglishWikipedia
        else               Vocabulary::Standard
      end
    end

    # Converts a `Vocabulary` to a string.
    def self.to_s(vocabulary : Vocabulary) : String?
      case vocabulary
        when Vocabulary::Spanish          then "es"
        when Vocabulary::EnglishWikipedia then "enwiki"
        else                                   nil
      end
    end
  end
end
