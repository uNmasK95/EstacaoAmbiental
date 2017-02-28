require 'mongo'

class DataDAO

  Mongo::Logger.logger.level = ::Logger::FATAL

  def initialize()
    @client = Mongo::Client.new(['127.0.0.1:27017'])
    @db = @client.use("xdkAmbiente")
  end


  def init()
    #@db.createCollection
  end

  def insert( sensorID, sensorType, value, timestamp, gps_lat, gps_lon)
    leitura = {
        :_id => {
            :id => sensorID,
            :timestamp => timestamp
        },
        :type => sensorType,
        :value => value,
        :gps => {
            :lat => gps_lat,
            :lon => gps_lon
        }
    }

    print @db[:leituras].insert_one leitura
  end

  def getAllByID
    #db.leituras.find( {$and:[{"_id.id":1},{"_id.timestamp":{$gt:1488316920}}]})
  end

  def getLastID
    
  end

  def getLeiturasByConId(id, last_timestamp)
    @db[:leituras].find({
        $and : [ { "_id.id": id}, { "_id.timestamp": {$gt:last_timestamp} }]
    })
  end
end



d = DataDAO.new
d.insert(2,"ruido",5.2,Time.now.to_i, 58.1, -47.9)