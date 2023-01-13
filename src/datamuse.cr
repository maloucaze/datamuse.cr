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

  # The maximum number of topics that can be sent when searching for words.
  MAX_TOPICS = 5

  # Searches for words on Datamuse given a set of constraints.
  #
  # Sends a request to /words.
  def self.find_words(
    constraints : Constraints,
    metadata : Metadata = DEFAULT_METADATA,
    topics : Array(String) = [] of String,
    left_context : String? = nil,
    right_context : String? = nil,
    max_results : Int32 = DEFAULT_NUM_RESULTS
  ) : Array(Word)
    if topics.size > MAX_TOPICS
      raise ArgumentError.new(
        "Size of `topics` cannot be greater than #{MAX_TOPICS}"
      )
    end

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
      query.add("topics", topics) unless topics.empty?
      query.add("lc", left_context) unless left_context.nil?
      query.add("lr", right_context) unless right_context.nil?
      query.add("max", max_results.to_s)
    end

    uri = URI.new(scheme: "https", host: HOST, path: "/words", query: params)
    res = HTTP::Client.get(uri)

    res.success? ? Array(Word).from_json(res.body) : [] of Word
  end
end
