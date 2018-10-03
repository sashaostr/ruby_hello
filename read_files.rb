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
      words.each { |name| counts[name] += 1 }
      puts counts

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


path = ARGV.first
puts path
wc = WordsCounter.new(path)
wc.count_words()
