
require 'mysql2'
require './lib/abstract_db_connector'

class MySqlConnector < AbstractDBConnector

  def initialize(dbname, table)
    @dbname = dbname
    @table = table
  end

  def connect
    @con = Mysql2::Client.new(:host => "localhost", :username => "root")
    # return con

    rescue Mysql2::Error => e
      puts e.errno
      puts e.error

    # ensure
    #   @con.close if @con
  end


  def store_to_db(word_count_hash)
    result = @con.query("CREATE DATABASE IF NOT EXISTS #{@dbname}")

    @con.query("CREATE TABLE IF NOT EXISTS #{@dbname}.#{@table} (word CHAR(100), count INT);")

    insert_statements = word_count_hash.map {|word,count|
      "INSERT INTO #{@dbname}.#{@table}  (word,count) VALUES ('#{word}', #{count});"
    }
    insert_statements.each do |statement|
      @con.query(statement)
      # puts statment
    end


  end

  def disconnect
    @con.close
  end

end