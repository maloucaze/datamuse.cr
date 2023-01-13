require "http/client"
require "json"
require "uri"

require "./datamuse/arpabet"
require "./datamuse/arpabet/phoneme"
require "./datamuse/constraints"
require "./datamuse/metadata"
require "./datamuse/part_of_speech"
require "./datamuse/vocabulary"
require "./datamuse/word"

# A client library for the Datamuse HTTP API.
module Datamuse
  # The version of this shard.
  VERSION = "0.1.0"

  # The host of Datamuse API.
  HOST = "api.datamuse.com"

  # The default metadata options that will be sent when searching for words.
  DEFAULT_METADATA = Metadata.new

  # The default number of results returned.
  DEFAULT_NUM_RESULTS = 100

  # The maximum number of results that can be returned.
  MAX_RESULTS = 1000

  # Searches for words on Datamuse given a set of constraints.
  def self.find_words(
    constraints : Constraints,
    metadata : Metadata = DEFAULT_METADATA,
    max_results : Int32 = DEFAULT_NUM_RESULTS
  ) : Array(Word)
    if max_results < 0
      raise ArgumentError.new("`max_results` must be greater than 0")
    end

    if max_results > MAX_RESULTS
      raise ArgumentError.new(
        "`max_results` cannot be greater than #{MAX_RESULTS}"
      )
    end

    params = URI::Params.build do |query|
      constraints.to_h.each { |k, v| query.add(k, v) }
      query.add("md", metadata.to_s) unless metadata.to_s.empty?
      query.add("max", max_results.to_s)
    end

    uri = URI.new(scheme: "https", host: HOST, path: "/words", query: params)
    res = HTTP::Client.get(uri)

    res.success? ? Array(Word).from_json(res.body) : [] of Word
  end
end

constraints = Datamuse::Constraints.new(
  perfectly_rhymes_with: "declare"
)

metadata = Datamuse::Metadata.new(
  show_pronunciation: true,
  show_parts_of_speech: true
)

res = Datamuse.find_words(constraints)

pp res[0]
