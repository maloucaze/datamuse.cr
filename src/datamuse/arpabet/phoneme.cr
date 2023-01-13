module Datamuse::Arpabet
  # An Arpabet phoneme.
  struct Phoneme
    # The types of stress represented in Arpabet.
    enum Stress : UInt8
      None      = 0
      Primary   = 1
      Secondary = 2
    end

    # The code of the phoneme.
    getter code : String

    # The type of stress, if any.
    getter stress : Stress?

    private def initialize(@code, @stress = nil); end

    # Parses an Arpabet phoneme.
    def self.parse(str : String) : Phoneme
      code = String::Builder.new
      stress = nil

      str.each_char do |char|
        case char
          when '0' then stress = Stress::None
          when '1' then stress = Stress::Primary
          when '2' then stress = Stress::Secondary
          else          code << char
        end
      end

      new(code.to_s, stress)
    end

    # Transforms the phoneme into an Arpabet-compliant phoneme.
    def to_s(io : IO) : Nil
      io << "#{@code}#{@stress.not_nil!.value unless @stress.nil?}"
    end
  end
end
