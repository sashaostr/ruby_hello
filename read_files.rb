require './mysql_connector'
require './mongodb_connector'
require 'mysql2'

class WordsCounter
  def initialize(path,db)
    @path = path
    @db = db
  end

  def count_words
    if (@path.nil? || @path.empty?)
      puts "empty path"
    else
      files = Dir.glob("#{@path}/**/*.txt")
      puts "found #{files.size} files"

      words = files.map {|f| get_words(f)}.map {|text| text.split(/\W+/) } .flatten
      counts = Hash.new(0)
      words.each { |word| counts[word] += 1 }
      counts_ordered = counts.sort_by { |_, count| count }.reverse
      puts counts_ordered
      #

      @db.connect
      @db.store_to_db(counts_ordered)
      @db.disconnect
    end
  end

  def get_words(file_path)
    return File.read(file_path)
    # File.open(file_path, "r") do |f|
      # f.each_line do |line|
      #   yield line
      # end
    # end
  end

end



path = ARGV[0]
puts path
dbname = ARGV[1]
puts dbname

case dbname
when "mongo"
  db = MongoDBConnector.new("onboard", "wordcount")
when "mysql"
  db = MySqlConnector.new("onboard", "wordcount")
else
  raise "Unknown db"
end

wc = WordsCounter.new(path,db)
wc.count_words()
