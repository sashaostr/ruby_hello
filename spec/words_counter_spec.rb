require 'rspec'
require_relative '../lib/words_counter'


describe 'process directory with files' do

  path = "../data/"
  puts "path:#{path}"


  let(:word_updater) {
    updater = double(:word_updater)
    updater.stub(:update){ |word|
      puts word
    }
    updater
  }
  let(:word_counter3) {WordsCounters::WordsCounter3.new(path, word_updater)}

  it 'count words correctly' do
    expect(word_counter3.process_text("bla bla bla soba soba", "path/path").length).to eq(2)
  end


  it 'call update for every new word' do

    # word_counter3.stub(:word_updater, double(:word_updater_print, :update=> lambda{|word|
    #   puts word }
    # ))

    word_counter3.stub(:get_files => ["bla/file.txt"])
    word_counter3.stub(:get_words => "bla bla bla soba soba")

    word_updater.should_receive(:update).exactly(2).times
    word_counter3.process_path



  end


  # it 'counts words and update words in mongodb' do
  #
  #   word_updater = double(:mongo_word_updater, update: nil)
  #   wc = WordCounters::WordsCounter3.new(path, word_updater)
  #   wc.process_path()
  #
  #
  #   :expect == true
  # end


end



