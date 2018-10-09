require 'rspec'
require_relative '../lib/words_counter_old'
require_relative '../lib/words_counter'

describe 'process directory with files' do


  path = "../data/"
  # puts FileUtils.pwd
  puts "path:#{path}"

  it 'counts words in files' do

    wc = WordsCounters::WordsCounter1.new(path)
    res = wc.count_words()

    :expect == res.length > 0
  end

  it 'counts words in files 2' do

    wc = WordsCounters::WordsCounter2.new(path)
    res = wc.count_words()

    :expect == res.length > 0
  end



end



