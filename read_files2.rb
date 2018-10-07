require './mysql_connector'
require './mongodb_connector'
require 'mysql2'
require 'json'


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

      words = files
      .map{ |f|
        text = get_words(f)
        words = text.split(/\W+/)
        [words,f]
      }.flat_map{ |words,path|
       words.each_with_index.map { |w,i| {word:w, file_name: path, index: i} }
      }.reduce(Hash.new({})){ |hash, entry|
        key = entry[:word]
        current = hash[key].empty? ? { word: key, locations: [], count: 0 } : hash[key]
        current[:locations] << {index: entry[:index], file_name: entry[:file_name]}
        current[:count] += 1
        hash[key] = current
        hash
      }

     puts JSON.pretty_generate(words)


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
