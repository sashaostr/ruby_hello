
class WordsCounter
  def initialize(path)
    @path = path
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

      return counts_ordered


    end
  end

  def get_words(file_path)
    return File.read(file_path)
  end

end

class WordsCounter2
  def initialize(path)
    @path = path
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


      return words

    end
  end

  def get_words(file_path)
    return File.read(file_path)
  end

end

class WordsCounter3
  def initialize(path, word_updater)
    @path = path
    @word_updater = word_updater
  end

  def process_path
    if (@path.nil? || @path.empty?)
      puts "empty path"
    else
      files = Dir.glob("#{@path}/**/*.txt")
      puts "found #{files.size} files"

      files.each do |f|

        text = get_words(f)
        words = process_text(text, f).values
        # puts JSON.pretty_generate(words)

        words.each do |word|
          @word_updater.update(word)
        end
      end

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
end