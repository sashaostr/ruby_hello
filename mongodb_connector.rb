
require 'mongo'
require './abstract_db_connector'

class MongoDBConnector < AbstractDBConnector

  def initialize(dbname, table)
    @dbname = dbname
    @table = table
  end

  def connect
    @client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'onboard')
  end


  def store_to_db(word_counts)

    word_counts_jsons = word_counts.map {|word,count| {"word"=>word, "count"=>count}}

    @client[:wordscouns].insert_many word_counts_jsons

  end

  def disconnect
    @client.close
  end


end