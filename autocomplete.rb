#!/usr/bin/env ruby

require './lib/word_collection'

if ARGV[1]
  word_collection = WordCollection.new(File.read(ARGV[0]))
  matches = word_collection.matches_with_frequency(ARGV[1])

  puts matches.collect { |match| "#{match.keys[0]} (#{match.values[0]})" }
end
