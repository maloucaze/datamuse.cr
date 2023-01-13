module Datamuse
  # A set of constraints to search for words.
  #
  # These correspond to the "hard constraints" mentioned in the Datamuse API
  # documentation.
  struct Constraints
    getter means_like : String?
    getter sounds_like : String?
    getter spelled_like : String?
    getter nouns_for_adjective : String?
    getter adjectives_for_noun : String?
    getter synonymous_with : String?
    getter triggered_by : String?
    getter antonymous_to : String?
    getter more_general_than : String?
    getter kind_of : String?
    getter part_of : String?
    getter comprises : String?
    getter frequent_followers_of : String?
    getter frequent_predecessors_of : String?
    getter perfectly_rhymes_with : String?
    getter approximately_rhymes_with : String?
    getter homophone_to : String?
    getter matches_consonants_of : String?
    getter vocabulary : Vocabulary | String

    def initialize(
      @means_like = nil, @sounds_like = nil, @spelled_like = nil,
      @nouns_for_adjective = nil, @adjectives_for_noun = nil,
      @synonymous_with = nil, @triggered_by = nil, @antonymous_to = nil,
      @more_general_than = nil, @kind_of = nil, @part_of = nil,
      @comprises = nil, @frequent_followers_of = nil,
      @frequent_predecessors_of = nil, @perfectly_rhymes_with = nil,
      @approximately_rhymes_with = nil, @homophone_to = nil,
      @matches_consonants_of = nil, @vocabulary = Vocabulary::Standard
    ); end

    # Converts the constraints to a hash.
    def to_h : Hash(String, String)
      hash = {} of String => String

      add_to_hash("ml", @means_like, hash)
      add_to_hash("sl", @sounds_like, hash)
      add_to_hash("sp", @spelled_like, hash)
      add_to_hash("jja", @nouns_for_adjective, hash)
      add_to_hash("jjb", @adjectives_for_noun, hash)
      add_to_hash("syn", @synonymous_with, hash)
      add_to_hash("trg", @triggered_by, hash)
      add_to_hash("ant", @antonymous_to, hash)
      add_to_hash("spc", @more_general_than, hash)
      add_to_hash("gen", @kind_of, hash)
      add_to_hash("com", @part_of, hash)
      add_to_hash("par", @comprises, hash)
      add_to_hash("bga", @frequent_followers_of, hash)
      add_to_hash("bgb", @frequent_predecessors_of, hash)
      add_to_hash("rel_rhy", @perfectly_rhymes_with, hash)
      add_to_hash("rel_nry", @approximately_rhymes_with, hash)
      add_to_hash("hom", @homophone_to, hash)
      add_to_hash("cns", @matches_consonants_of, hash)

      vocabulary = @vocabulary
      if vocabulary.is_a?(Vocabulary)
        add_to_hash("v", VocabularyConverter.to_s(vocabulary), hash)
      else
        add_to_hash("v", vocabulary, hash)
      end

      hash
    end

    # :nodoc:
    #
    # Utility to add a key-value pair to a hash while checking for nil.
    private def add_to_hash(k : String, v, hash : Hash) : Nil
      hash[k] = v.not_nil! unless v.nil?
    end
  end
end
