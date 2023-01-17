module Datamuse
  # The structure of words sent as response from the Datamuse API.
  struct Word
    include JSON::Serializable

    @[JSON::Field(ignore: true)]
    @parts_of_speech : Array(PartOfSpeech)? = nil

    @[JSON::Field(ignore: true)]
    @pronunciation : Array(Phono::Phoneme)? = nil

    @[JSON::Field(ignore: true)]
    @word_frequency : Float32? = nil

    # The word itself.
    @[JSON::Field]
    getter word : String

    # A rank of the result.
    @[JSON::Field]
    getter score : Int32?

    # The number of syllables in the word.
    @[JSON::Field(key: "numSyllables")]
    getter num_syllables : Int32?

    # The extra tags containing more information about the word.
    #
    # This should not be used by the programmer, as all the results are properly
    # extracted into their own properties of `Word` (e.g.,)
    @[JSON::Field]
    getter tags : Array(String)?

    # Some definitions of the word.
    @[JSON::Field(key: "defs")]
    getter definitions : Array(String)?

    # The parts of speech that the word is. Extracted from `#tags`.
    #
    # This result is memoized.
    def parts_of_speech : Array(PartOfSpeech)
      mem_pos = @parts_of_speech
      return mem_pos unless mem_pos.nil?

      parts = [] of PartOfSpeech

      return parts if @tags.nil?

      @tags.not_nil!.each do |tag|
        pos = PartOfSpeechConverter.from_s(tag.downcase)
        parts << pos unless pos.nil?
      end

      @parts_of_speech = parts
    end

    # The pronunciation of the word (ARPABET). Extracted from `#tags`.
    #
    # This result is memoized.
    def pronunciation : Array(Phono::Phoneme)?
      mem_pron = @pronunciation
      return mem_pron unless mem_pron.nil?

      return nil if @tags.nil?

      pronunciation = nil
      @tags.not_nil!.each do |tag|
        if tag.starts_with?("pron:")
          pronunciation = Phono::ARPABET.parse(tag.split(':')[1])
          break
        end
      end

      @pronunciation = pronunciation
    end

    # The number of times the word occurs per million words of English text
    # according to Google Books Ngrams. Extracted from `#tags`.
    #
    # This result is memoized.
    def word_frequency : Float32?
      mem_freq = @word_frequency
      return mem_freq unless mem_freq.nil?

      return nil if @tags.nil?

      frequency = nil
      @tags.not_nil!.each do |tag|
        if tag.starts_with?("f:")
          frequency = tag.split(':')[1].to_f32
          break
        end
      end

      @word_frequency = frequency
    end
  end
end
