require 'rspec'
require_relative '../lib/read_files'

describe 'process directory with files' do

  @path = "../data/"

  it 'run without errors' do

    db = double(:db, store_to_db: nil)
    wc = WordsCounter.new(@path, db)
    wc.count_words()

    true.should == true
  end

  # it "prods the thingie at most once" do
  #   # Arrange
  #   thingie = double(:thingie, prod: "")
  #   subject = Detective.new(thingie)
  #
  #   # Act
  #   subject.investigate
  #   subject.investigate
  #
  #   # Assert
  #   expect(thingie).to have_received(:prod).once
  # end
  #
  # it "prods the thingie at most once" do
  #   thingie = double(:thingie)
  #   expect(thingie).to receive(:prod).once
  #   subject = Detective.new
  #
  #   subject.investigate
  #   subject.investigate
  # end
  #
  # it "says what noise the thingie makes" do
  #   thingie = double(:thingie, prod: "oi")
  #   subject = Detective.new(thingie)
  #
  #   result = subject.investigate
  #
  #   expect(result).to eq "It went 'oi'"
  # end

end



