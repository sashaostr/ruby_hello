require './mongodb_connector'
require 'json'


class WordsCounter3
  def initialize(path)
    @path = path
    @table = "wordcount3"
    @db = MongoDBConnector.new("onboard", @table)
  end

  def count_words
    if (@path.nil? || @path.empty?)
      puts "empty path"
    else
      files = Dir.glob("#{@path}/**/*.txt")
      puts "found #{files.size} files"
      @db.connect

      files.each do |f|

        text = get_words(f)
        words = process_text(text, f).values
        puts JSON.pretty_generate(words)

        words.each do |word|
          update_word(word)
        end
      end

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

  def process_text(text, path)
    words = text.split(/\W+/)
    .each_with_index
    .map { |w,i| {word:w, file_name: path, index: i} }
    .reduce(Hash.new({})){ |hash, entry|
      key = entry[:word]
      current = hash[key].empty? ? { word: key, locations: [], count: 0 } : hash[key]
      current[:locations] << {index: entry[:index], file_name: entry[:file_name]}
      current[:count] += 1
      hash[key] = current
      hash
    }
    return words
  end

  def update_word(entry)
    @db.client[@table].find_one_and_update({word: entry[:word]},
                                    {
                                      "$inc"=> {count: entry[:count]},
                                      "$push" => {locations: { "$each"=>entry[:locations] }}
                                    },
                                    :upsert => true
    )

  end

end



path = ARGV[0]
puts path


wc = WordsCounter3.new(path)
wc.count_words()
