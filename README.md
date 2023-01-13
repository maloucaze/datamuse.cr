# datamuse.cr

**datamuse.cr** is a [Crystal](https://crystal-lang.org/) client library for the
[Datamuse HTTP API](https://www.datamuse.com/api/).

### Note

> This is a work in progress.

#### TODO

- Implement method to send requests to */sug*
- Refactor and extract Arpabet-related code into a separate shard
- Review and implement specs

Searching for words on */words* given a set of constraints and a vocabulary is
fully supported.

## Install

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  datamuse:
    github: maloucaze/datamuse
```

2. Run `shards install`

## Usage

Require the shard as follows:

```cr
require "datamuse"
```

### Searching for words

```cr
constraints = Datamuse::Constraints.new(
  perfectly_rhymes_with: "declare"
)

# Without metadata options

Datamuse.find_words(constraints)
# => [Datamuse::Word(
#       @definitions=nil,
#       @num_syllables=1,
#       @parts_of_speech=nil,
#       @pronunciation=nil,
#       @score=17522,
#       @tags=nil,
#       @word="bear",
#       @word_frequency=nil
#     ), ...]

# With metadata options

metadata = Datamuse::Metadata.new(
  show_pronunciation: true,
  show_parts_of_speech: true
)

Datamuse.find_words(constraints, metadata)
# => [Datamuse::Word(
#       @definitions=nil,
#       @num_syllables=1,
#       @parts_of_speech=[Datamuse::PartOfSpeech::Adjective],
#       @pronunciation=[
#         Datamuse::Arpabet::Phoneme(@code="B", @stress=nil),
#         Datamuse::Arpabet::Phoneme(@code="EH", @stress=Primary),
#         Datamuse::Arpabet::Phoneme(@code="R", @stress=nil)
#       ],
#       @score=17522,
#       @tags=["adj", "pron:B EH1 R "],
#       @word="bear",
#       @word_frequency=nil
#     ), ...]
```

## Contributors

- [Nick Maloucaze](https://github.com/maloucaze) - creator and maintainer