module WordsCounters

  class WordsCounter3
    def initialize(path, word_updater)
      @path         = path
      @word_updater = word_updater
    end

    def process_path
      if (@path.nil? || @path.empty?)
        puts "empty path"
      else
        files = get_files(@path)
        puts "found #{files.size} files"

        files.each do |f|
          text  = get_words(f)
          words = process_text(text, f).values
          # puts JSON.pretty_generate(words)

          words.each do |word|
            @word_updater.update(word)
          end
        end

      end
    end

    def process_text(text, path)
      words = text.split(/\W+/)
                  .map(&:upcase)
                  .each_with_index
                  .map {|w, i| {word: w, file_name: path, index: i}}
                  .reduce(Hash.new({})) {|hash, entry|
                    key     = entry[:word]
                    current = hash[key].empty? ? {word: key, locations: [], count: 0} : hash[key]
                    current[:locations] << {index: entry[:index], file_name: entry[:file_name]}
                    current[:count] += 1
                    hash[key]       = current
                    hash
                  }
      return words
    end

    def get_words(file_path)
      return File.read(file_path)
    end

    def get_files(path)
      files = Dir.glob("#{path}/**/*.txt")
      return files
    end

  end

end