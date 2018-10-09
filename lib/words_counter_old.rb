module WordsCounters

  class WordsCounter1
    def initialize(path)
      @path = path
    end

    def count_words
      if (@path.nil? || @path.empty?)
        puts "empty path"
      else
        files = Dir.glob("#{@path}/**/*.txt")
        puts "found #{files.size} files"

        words  = files.map {|f| get_words(f)}.map {|text| text.split(/\W+/)}.flatten
        counts = Hash.new(0)
        words.each {|word| counts[word] += 1}
        counts_ordered = counts.sort_by {|_, count| count}.reverse

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
                    .map {|f|
                      text  = get_words(f)
                      words = text.split(/\W+/)
                      [words, f]
                    }.flat_map {|words, path|
          words.each_with_index.map {|w, i| {word: w, file_name: path, index: i}}
        }.reduce(Hash.new({})) {|hash, entry|
          key     = entry[:word]
          current = hash[key].empty? ? {word: key, locations: [], count: 0} : hash[key]
          current[:locations] << {index: entry[:index], file_name: entry[:file_name]}
          current[:count] += 1
          hash[key]       = current
          hash
        }


        return words

      end
    end

    def get_words(file_path)
      return File.read(file_path)
    end

  end


end