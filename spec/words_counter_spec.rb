require 'rspec'
require_relative '../lib/words_counter'


describe 'process directory with files' do

  path = "../data/"
  puts "path:#{path}"

  # word_updater = double("word_updater", :update => :return_value)
  let(:word_updater) { double(:word_updater, :update => lambda{|word|
    puts word }) }
  let(:word_counter3) {WordsCounters::WordsCounter3.new(path, word_updater)}



  it 'count words correctly' do

    word_updater.stub(:update){ |word|
      puts word
    }
    expect(word_counter3.process_text("bla bla bla soba soba", "path/path").length).to eq(2)

  end

  it 'call update for every new word' do

    # word_updater.stub(:update){ |word|
    #   puts word
    # }
    # word_updater.stub(:update => lambda{|word|
    #   puts word })
    #
    # word_counter3.stub(:word_updater, double(:word_updater_print, :update=> lambda{|word|
    #   puts word }
    # ))


    word_counter3.stub(:get_files => ["bla/file.txt"])

    word_counter3.stub(:get_words => "bla bla bla soba soba")


    expect(word_updater).to receive(:update)
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



