require_relative 'words_counter_old'
require 'mysql2'
require 'json'






path = ARGV[0]
puts path


wc = WordsCounter2.new(path)
words = wc.count_words()

puts JSON.pretty_generate(words)
