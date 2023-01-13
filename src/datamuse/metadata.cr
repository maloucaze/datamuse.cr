module Datamuse
  # Optional metadata that can be sent when searching for words.
  struct Metadata
    getter? show_definitions : Bool
    getter? show_parts_of_speech : Bool
    getter? show_syllable_count : Bool
    getter? show_pronunciation : Bool
    getter? show_word_frequency : Bool

    def initialize(
      @show_definitions = false, @show_parts_of_speech = false,
      @show_syllable_count = false, @show_pronunciation = false,
      @show_word_frequency = false
    ); end

    # Transforms the metadata options to a Datamuse-compliant string.
    def to_s(io : IO) : Nil
      io << "d" if @show_definitions
      io << "p" if @show_parts_of_speech
      io << "s" if @show_syllable_count
      io << "r" if @show_pronunciation
      io << "f" if @show_word_frequency
    end
  end
end
