# Sales Tax

Pure Ruby (no Rails or other frameworks). The only dependency is RSpec, used exclusively for testing.

## Requirements

- Ruby 3.3+ (tested with 3.3.10)
- Bundler

## Installation

```
bundle install
```

## Running the tests

```
bundle exec rspec
```

## Running the application

```
./bin/run <input_name>
```

`<input_name>` is the file name (without extension) of a basket in the `inputs/` directory, e.g.:

```
./bin/run input_1
```

## Assumptions

- The input has no explicit product category (book, food, medical), so it's inferred from keywords in each item's name (e.g. "book", "chocolate", "pill"). This is a simplification made because the challenge's input format doesn't provide this information explicitly — see `DECISIONS.md` for further reasoning and known limitations.
