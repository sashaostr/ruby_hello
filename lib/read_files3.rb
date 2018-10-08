require_relative 'mongodb_connector'
require_relative 'word_counter'
require 'json'


class MongoUpdater

  def initialize(mongo_connector, table_name)
    @connector = mongo_connector
    @table = table_name
  end
  def update(entry)

    @connector.client[@table].find_one_and_update({word: entry[:word]},
                                           {
                                               "$inc"  => {count: entry[:count]},
                                               "$push" => {locations: {"$each" => entry[:locations]}}
                                           },
                                           :upsert => true
    )

  end
end

path = ARGV[0]
puts path
table = "wordcount3"
db = MongoDBConnector.new("onboard", table)

db.connect

wc = WordsCounter3.new(path, MongoUpdater.new(db, table))
wc.process_path()
db.disconnect
