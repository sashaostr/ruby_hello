class AbstractDBConnector

  def connect
    raise NotImplementedError, 'You must implement the connect method'
  end

  def store_to_db(word_count_hash)
    raise NotImplementedError, 'You must implement the store_to_db method'
  end


  def disconnect
    raise NotImplementedError, 'You must implement the store_to_db method'
  end
end