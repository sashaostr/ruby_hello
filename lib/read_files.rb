require_relative 'mysql_connector'
require_relative 'mongodb_connector'
require_relative 'word_counter'
require 'mysql2'


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

wc = WordsCounter.new(path)
counts_ordered = wc.count_words()
puts counts_ordered
db.connect
db.store_to_db(counts_ordered)
db.disconnect